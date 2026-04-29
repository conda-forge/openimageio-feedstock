#!/bin/bash

set -euxo pipefail

output_kind="${OIIO_OUTPUT:?OIIO_OUTPUT must be set}"

source_root="${SRC_DIR}/oiio_src"

if [[ "${target_platform}" == "linux-aarch64" ]]; then
    # OIIO's NEON SIMD helpers use vector casts that GCC rejects on aarch64
    # without this compatibility flag.
    export CXXFLAGS="${CXXFLAGS:-} -flax-vector-conversions"
fi

python_executable="${PYTHON:-}"

build_dir="${SRC_DIR}/build-stage"

# The following advanced integrations are currently enabled:
#   - DICOM support via DCMTK.
#
# The following integrations remain intentionally off until their packaging are ready / possible / wanted :
#   - Ultra HDR via libuhdr.
#   - OpenCV bridge.
#   - OpenVDB support.
#   - Ptex support.
#   - RED R3D SDK support.

cmake_args=(
    -S "${source_root}"
    -B "${build_dir}"
    -G Ninja
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX="${PREFIX}"
    -DCMAKE_INSTALL_LIBDIR=lib
    -DCMAKE_INSTALL_INCLUDEDIR=include
    -DCMAKE_PREFIX_PATH="${PREFIX}"
    -DOpenImageIO_SUPPORTED_RELEASE=ON
    -DBUILD_SHARED_LIBS=ON
    -DBUILD_DOCS=OFF
    -DINSTALL_DOCS=OFF
    -DEMBEDPLUGINS=ON
    # Prefer conda-forge's shared fmt package over OIIO's bundled copy.
    -DOIIO_INTERNALIZE_FMT=OFF
    -DOpenImageIO_BUILD_STATIC_UTIL_LIBRARY=OFF
    -DOIIO_BUILD_TESTS=OFF
    -DBUILD_TESTING=OFF
    -DUSE_QT=OFF
    -DUSE_EXTERNAL_PUGIXML=OFF
    -DENABLE_PNG=ON
    -DENABLE_Freetype=ON
    -DENABLE_FFmpeg=ON
    -DENABLE_GIF=ON
    -DENABLE_Libheif=ON
    -DENABLE_LibRaw=ON
    -DENABLE_OpenJPEG=ON
    -DENABLE_WebP=ON
    -DENABLE_openjph=ON
    -DUSE_JXL=ON
    -DENABLE_TBB=ON
    -DENABLE_libuhdr=OFF
    -DUSE_FFMPEG=ON
    -DENABLE_OpenCV=OFF
    -DENABLE_OpenVDB=OFF
    -DENABLE_Ptex=OFF
    -DENABLE_DCMTK=ON
    -DUSE_R3DSDK=OFF
    -DOIIO_BUILD_TOOLS=ON
    -DINSTALL_FONTS=ON
    -DENABLE_iconvert=ON
    -DENABLE_idiff=ON
    -DENABLE_igrep=ON
    -DENABLE_iinfo=ON
    -DENABLE_maketx=ON
    -DENABLE_oiiotool=ON
    -DENABLE_INSTALL_iconvert=OFF
    -DENABLE_INSTALL_idiff=OFF
    -DENABLE_INSTALL_igrep=OFF
    -DENABLE_INSTALL_iinfo=OFF
    -DENABLE_INSTALL_maketx=OFF
    -DENABLE_INSTALL_oiiotool=OFF
    -DENABLE_iv=OFF
    -DENABLE_testtex=OFF
)

case "${output_kind}" in
    tools-staged)
        # CMake's normal install also records these executables in
        # lib/cmake/OpenImageIO/OpenImageIOTargets.cmake. This output only needs
        # the binaries, so copy the staged tools directly.
        mkdir -p "${PREFIX}/bin"
        cp "${build_dir}/bin/"* "${PREFIX}/bin/"
        exit 0
        ;;
    core-staged)
        # The core library does not depend on Python or OIIO's CLI tools, so disable those integrations.
        cmake_args+=(-DUSE_PYTHON=OFF)
        ;;
    python-staged)
        # Use the active conda Python's sysconfig. In cross builds this may be
        # a wrapper that reports target-platform include paths.
        python_include_dir="$("${python_executable}" -c 'import sysconfig; print(sysconfig.get_path("include"))')"
        cmake_args+=(
            -DUSE_PYTHON=ON
        )
        if [[ -n "${PY_VER:-}" ]]; then
            # Select the exact CPython variant for PyOpenImageIO (Patch 0004
            # only keeps this from dirtying the staged core library target).
            cmake_args+=("-DPYTHON_VERSION=${PY_VER}")
        fi
        if [[ -n "${python_executable}" ]]; then
            cmake_args+=(
                -DPython_EXECUTABLE="${python_executable}"
                -DPython_INCLUDE_DIR="${python_include_dir}"
                -DPython3_EXECUTABLE="${python_executable}"
                -DPython3_INCLUDE_DIR="${python_include_dir}"
            )
        fi
        ;;
    *)
        echo "Unsupported OIIO_OUTPUT value: ${output_kind}" >&2
        exit 1
        ;;
esac

if [[ -n "${CMAKE_ARGS:-}" ]]; then
    # conda/rattler injects compiler, sysroot, and platform flags through this
    # shell-style argument list. Keep it last so platform overrides still win.
    # shellcheck disable=SC2206
    cmake_args+=( ${CMAKE_ARGS} )
fi

cmake "${cmake_args[@]}"
if [[ "${output_kind}" == "python-staged" ]]; then
    cmake --build "${build_dir}" --target PyOpenImageIO --parallel "${CPU_COUNT}"
else
    cmake --build "${build_dir}" --parallel "${CPU_COUNT}"
fi
cmake --install "${build_dir}"

# Remove the docs directory that was installed by OCIO_BUILD_DOCS=ON, which is not needed for OpenImageIO and takes up space.
rm -rf "${PREFIX}/share/doc/OpenImageIO"
