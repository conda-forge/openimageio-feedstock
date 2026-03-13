#!/bin/bash
set -ex

OIIO_BUILD_PYTHON="${OIIO_BUILD_PYTHON:-1}"

export CXXFLAGS="$CXXFLAGS -DGIFLIB_MAJOR=5"

if [ ${target_platform} == "linux-aarch64" ]; then
    export CXXFLAGS="$CXXFLAGS -flax-vector-conversions"
fi

mkdir -p ${PREFIX}/bin

mkdir -p build

pushd build;

if [[ "${target_platform}" != "${build_platform}" ]]; then
    # PyBind11 will find python3.X which returns a different
    # value for the "EXT_SUFFIX" which is inconsistent with
    # cross compilation
    # https://github.com/conda-forge/cross-python-feedstock/issues/75
    Python_EXECUTABLE=${BUILD_PREFIX}/bin/python
else
    Python_EXECUTABLE=${PYTHON}
fi

cmake_args=(
    -G Ninja
    ${CMAKE_ARGS}
    -DUSE_FFMPEG=ON
    -DOIIO_BUILD_TOOLS=OFF
    -DOIIO_BUILD_TESTS=OFF
    -DUSE_OPENCV=OFF
    -DCMAKE_BUILD_TYPE=Release
    -DBUILD_MISSING_FMT=OFF
    -DINTERNALIZE_FMT=OFF
)

if [[ "${OIIO_BUILD_PYTHON}" == "1" ]]; then
    cmake_args+=(
        -DUSE_PYTHON=ON
        -DPYTHON_VERSION=${PY_VER}
        -DPython_EXECUTABLE=${Python_EXECUTABLE}
    )
else
    cmake_args+=(-DUSE_PYTHON=OFF)
fi

cmake "${cmake_args[@]}" ..

cmake --build . --config Release
cmake --install . --prefix=$PREFIX

# remove folders that should not be needed at runtime by conda-forge packages.
rm -rf $PREFIX/share/doc/OpenImageIO

popd
