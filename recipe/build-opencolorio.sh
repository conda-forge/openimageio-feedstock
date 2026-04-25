#!/bin/bash

set -euo pipefail

# OpenColorIO build script following official installation instructions
# https://opencolorio.readthedocs.io/en/latest/quick_start/installation.html

OCIO_BUILD_APPS="${OCIO_BUILD_APPS:-OFF}"
OCIO_BUILD_PYTHON="${OCIO_BUILD_PYTHON:-OFF}"
OCIO_USE_OIIO_FOR_APPS="${OCIO_USE_OIIO_FOR_APPS:-OFF}"

python_executable="${PYTHON:-}"

mkdir -p build_ocio
pushd build_ocio

cmake_args=(
    -GNinja
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

# OCIO_BUILD_DOCS=ON enables Doxygen-based docstring extraction for Python bindings.
# Building PyOpenColorIO with docs disabled produces incomplete Python docstrings.
#
if [[ "${OCIO_BUILD_PYTHON}" == "ON" ]]; then
    cmake_args+=(
        -DOCIO_BUILD_DOCS=ON
        -DOCIO_PYTHON_VERSION="${PY_VER}"
        # Use conda-forge's active Python. For cross builds, cross-python sets
        # this to a build-platform wrapper with target-platform Python metadata.
        -DPython_EXECUTABLE="${python_executable}"
    )
else
    cmake_args+=(-DOCIO_BUILD_DOCS=OFF)
fi

if [[ -n "${CMAKE_ARGS:-}" ]]; then
    # shellcheck disable=SC2206
    extra_cmake_args=( ${CMAKE_ARGS} )
    cmake_args=("${cmake_args[@]}" "${extra_cmake_args[@]}")
fi

cmake "${cmake_args[@]}" ../ocio_src
if [[ "${OCIO_BUILD_PYTHON}" == "ON" ]]; then
    # PyOpenColorIO needs the docstring_extraction target (part of
    # OCIO_BUILD_DOCS) to generate Python docstrings from Doxygen output.
    # Building the default ALL target would also invoke sphinx-build, which
    # fails due to missing theme packages, so build only the PyOpenColorIO target.
    cmake --build . --config Release --target PyOpenColorIO -j"${CPU_COUNT:-1}"
    # docs/cmake_install.cmake installs build-html/ regardless of whether Sphinx
    # ran. Create an empty placeholder so cmake --install does not fail.
    mkdir -p docs/build-html
    cmake --install . --config Release
else
    cmake --build . --config Release --target install -j"${CPU_COUNT:-1}"
fi

# For tools and python outputs: remove files owned by the base OCIO package
# to avoid output overlap.
if [[ "${OCIO_BUILD_APPS}" == "ON" || "${OCIO_BUILD_PYTHON}" == "ON" ]]; then
    rm -rf "${PREFIX}/include/OpenColorIO"
    rm -rf "${PREFIX}/lib/cmake/OpenColorIO"
    rm -f "${PREFIX}"/lib/libOpenColorIO*
    rm -f "${PREFIX}"/lib/libOpenColorIO*.a
    rm -f "${PREFIX}"/lib/pkgconfig/OpenColorIO*.pc
    rm -rf "${PREFIX}/share/doc/OpenColorIO"
fi

popd
