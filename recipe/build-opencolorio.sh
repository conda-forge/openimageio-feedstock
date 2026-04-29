#!/bin/bash

set -euo pipefail

# OpenColorIO build script following official installation instructions
# https://opencolorio.readthedocs.io/en/latest/quick_start/installation.html

OCIO_BUILD_APPS="${OCIO_BUILD_APPS:-OFF}"
OCIO_BUILD_PYTHON="${OCIO_BUILD_PYTHON:-OFF}"
OCIO_USE_OIIO_FOR_APPS="${OCIO_USE_OIIO_FOR_APPS:-OFF}"

python_executable="${PYTHON:-}"
build_dir="${SRC_DIR}/build_ocio"

cmake_args=(
    -S "${SRC_DIR}/ocio_src"
    -B "${build_dir}"
    -G Ninja
    -DCMAKE_INSTALL_PREFIX="${PREFIX}"
    -DCMAKE_BUILD_TYPE=Release
    -DBUILD_SHARED_LIBS=ON
    -DOCIO_BUILD_APPS="${OCIO_BUILD_APPS}"
    -DOCIO_BUILD_PYTHON="${OCIO_BUILD_PYTHON}"
    -DOCIO_BUILD_OPENFX=OFF
    -DOCIO_BUILD_JAVA=OFF
    -DOCIO_BUILD_TESTS=OFF
    -DOCIO_BUILD_GPU_TESTS=OFF
    # OFF for the base and python outputs to avoid a circular dependency.
    # ON only for the tools output, which intentionally comes after OIIO.
    -DOCIO_USE_OIIO_FOR_APPS="${OCIO_USE_OIIO_FOR_APPS}"
    -DOCIO_WARNING_AS_ERROR=OFF
    -DOCIO_USE_SIMD=ON
    # Ensure the shared library uses upstream SOVERSION scheme:
    # libOpenColorIO.so.2.5.1 with SONAME libOpenColorIO.so.2.5 (+ symlinks)
    -DOCIO_USE_SOVERSION=ON
    # Dependency installation strategy:
    # NONE: Use installed packages, fail if missing
    # MISSING: Prefer installed, install if missing
    # ALL: Install all required packages regardless
    # ==> All dependencies come from conda; never download at build time.
    -DOCIO_INSTALL_EXT_PACKAGES=NONE
)

if [[ "${target_platform}" == osx-* ]]; then
    # conda-forge supports older macOS deployment targets than the SDK headers
    # expose by default; disable libc++ availability annotations during build.
    export CXXFLAGS="${CXXFLAGS:-} -D_LIBCPP_DISABLE_AVAILABILITY"
    # OCIO's Apple hidden-link logic keys off minizip_LIBRARY for compat-mode builds.
    # conda-forge's minizip package currently ships libminizip without the compat
    # marker OCIO expects, so provide the library path explicitly until the
    # minizip feedstock exports that metadata itself.
    cmake_args+=( -Dminizip_LIBRARY="${PREFIX}/lib/libminizip.dylib" )
fi

# SIMD: explicitly enable per-architecture instruction sets.
# OCIO uses runtime dispatch (CPUInfo), so higher instruction sets are
# compiled in but only used on supported CPUs at runtime.
if [[ "${target_platform}" == linux-64 || "${target_platform}" == osx-64 ]]; then
    cmake_args+=(
        -DOCIO_USE_SSE2=ON
        -DOCIO_USE_SSE3=ON
        -DOCIO_USE_SSSE3=ON
        -DOCIO_USE_SSE4=ON
        -DOCIO_USE_SSE42=ON
        -DOCIO_USE_AVX=ON
        -DOCIO_USE_AVX2=ON
        -DOCIO_USE_AVX512=ON
        -DOCIO_USE_F16C=ON
    )
elif [[ "${target_platform}" == linux-aarch64 || "${target_platform}" == osx-arm64 ]]; then
    cmake_args+=(-DOCIO_USE_SSE2NEON=ON)
fi

# Headless EGL: on Linux, apps can create a GL context via EGL without an X server.
# macOS uses system GL and does not need this.
if [[ "${target_platform}" == linux-* ]] && [[ "${OCIO_BUILD_APPS}" == "ON" ]]; then
    cmake_args+=(-DOCIO_USE_HEADLESS=ON)
else
    cmake_args+=(-DOCIO_USE_HEADLESS=OFF)
fi

# Building PyOpenColorIO with docs disabled produces incomplete Python docstrings.
# OCIO_BUILD_DOCS=ON enables Doxygen-based docstring extraction for Python bindings.
#
if [[ "${OCIO_BUILD_PYTHON}" == "ON" ]]; then
    # Use the active conda Python's sysconfig. In cross builds this may be a
    # wrapper that reports target-platform include paths.
    python_include_dir="$("${python_executable}" -c 'import sysconfig; print(sysconfig.get_path("include"))')"
    cmake_args+=(
        -DOCIO_BUILD_DOCS=ON
        -DOCIO_PYTHON_VERSION="${PY_VER}"
        -DPython_EXECUTABLE="${python_executable}"
        -DPython_INCLUDE_DIR="${python_include_dir}"
    )
else
    cmake_args+=(-DOCIO_BUILD_DOCS=OFF)
fi

if [[ -n "${CMAKE_ARGS:-}" ]]; then
    # conda/rattler injects compiler, sysroot, and platform flags through this
    # shell-style argument list. Keep it last so platform overrides still win.
    # shellcheck disable=SC2206
    cmake_args+=( ${CMAKE_ARGS} )
fi

cmake "${cmake_args[@]}"
if [[ "${OCIO_BUILD_PYTHON}" == "ON" ]]; then
    # PyOpenColorIO needs the docstring_extraction target (part of
    # OCIO_BUILD_DOCS) to generate Python docstrings from Doxygen output.
    # Building the default ALL target would also invoke sphinx-build, which
    # fails due to missing theme packages, so build only the PyOpenColorIO target.
    cmake --build "${build_dir}" --config Release --target PyOpenColorIO -j"${CPU_COUNT}"
    # docs/cmake_install.cmake installs build-html/ regardless of whether Sphinx
    # ran. Create an empty placeholder so cmake --install does not fail.
    mkdir -p "${build_dir}/docs/build-html"
    cmake --install "${build_dir}" --config Release
else
    cmake --build "${build_dir}" --config Release --target install -j"${CPU_COUNT}"
fi
