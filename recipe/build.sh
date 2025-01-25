#!/bin/bash
set -ex

export CXXFLAGS="$CXXFLAGS -DGIFLIB_MAJOR=5"

if [ ${target_platform} == "linux-aarch64" ]; then
    export CXXFLAGS="$CXXFLAGS -flax-vector-conversions"
fi

mkdir -p ${PREFIX}/bin

mkdir build

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

cmake -G Ninja \
    ${CMAKE_ARGS} \
    -DUSE_FFMPEG=ON \
    -DOIIO_BUILD_TOOLS=OFF \
    -DOIIO_BUILD_TESTS=OFF \
    -DUSE_PYTHON=ON \
    -DUSE_OPENCV=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    -DPYTHON_VERSION=$PY_VER \
    -DPython_EXECUTABLE=${Python_EXECUTABLE} \
    -DBUILD_MISSING_FMT=OFF \
    -DINTERNALIZE_FMT=OFF \
    ..

# Do not install, only build.
cmake --build . --config Release

popd
