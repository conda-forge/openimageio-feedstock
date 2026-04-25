#!/bin/bash

set -euxo pipefail

output_kind="${OIIO_OUTPUT:-core}"

source_root="${SRC_DIR}/oiio_src"

if [[ ! -f "${source_root}/CMakeLists.txt" ]]; then
    echo "Could not find OpenImageIO source root at ${source_root}" >&2
    find "${SRC_DIR}" -maxdepth 2 -name CMakeLists.txt -print >&2 || true
    exit 1
fi

export CXXFLAGS="${CXXFLAGS:-} -DGIFLIB_MAJOR=5"

if [[ "${target_platform}" == "linux-aarch64" ]]; then
    export CXXFLAGS="${CXXFLAGS} -flax-vector-conversions"
fi

python_executable="${PYTHON:-}"

build_dir="${SRC_DIR}/build-${output_kind}"

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
)

# The following advanced integrations are currently enabled:
#   - DICOM support via DCMTK.
#
# The following integrations remain intentionally off until their packaging are ready:
#   - OpenCV bridge.
#   - OpenVDB support.
#   - Ptex support.
#   - Ultra HDR via libuhdr.
#   - RED R3D SDK support.

if [[ -n "${CMAKE_ARGS:-}" ]]; then
    # shellcheck disable=SC2206
    extra_cmake_args=( ${CMAKE_ARGS} )
    cmake_args=("${cmake_args[@]}" "${extra_cmake_args[@]}")
fi

case "${output_kind}" in
    core)
        cmake_args+=(
            -DOIIO_BUILD_TOOLS=OFF
            -DINSTALL_FONTS=ON
            -DUSE_PYTHON=OFF
            -DENABLE_iv=OFF
            -DENABLE_testtex=OFF
        )
        ;;
    tools)
        cmake_args+=(
            -DOIIO_BUILD_TOOLS=ON
            -DINSTALL_FONTS=OFF
            -DUSE_PYTHON=OFF
            -DENABLE_iconvert=ON
            -DENABLE_idiff=ON
            -DENABLE_igrep=ON
            -DENABLE_iinfo=ON
            -DENABLE_maketx=ON
            -DENABLE_oiiotool=ON
            -DENABLE_iv=OFF
            -DENABLE_testtex=OFF
        )
        ;;
    python)
        python_include_dir="$("${python_executable}" -c 'import sysconfig; print(sysconfig.get_path("include"))')"
        cmake_args+=(
            -DOIIO_BUILD_TOOLS=OFF
            -DINSTALL_FONTS=OFF
            -DUSE_PYTHON=ON
            -DENABLE_iv=OFF
            -DENABLE_testtex=OFF
        )
        if [[ -n "${PY_VER:-}" ]]; then
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

cmake "${cmake_args[@]}"
cmake --build "${build_dir}" --parallel "${CPU_COUNT:-1}"
cmake --install "${build_dir}"

rm -rf "${PREFIX}/share/doc/OpenImageIO"

if [[ "${output_kind}" == "tools" || "${output_kind}" == "python" ]]; then
    rm -rf "${PREFIX}/include/OpenImageIO"
    rm -rf "${PREFIX}/lib/cmake/OpenImageIO"
    rm -f "${PREFIX}"/lib/libOpenImageIO*
    rm -f "${PREFIX}"/lib/libOpenImageIO_Util*
    rm -f "${PREFIX}"/lib/pkgconfig/OpenImageIO.pc
    rm -rf "${PREFIX}/share/fonts/OpenImageIO"
fi
