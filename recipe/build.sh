#!/bin/bash

export CXXFLAGS="$CXXFLAGS -DGIFLIB_MAJOR=5"

mkdir -p ${PREFIX}/bin

mkdir build

pushd build;
PYTHON_MODULE_EXTENSION=$(python -c "import sysconfig; print(sysconfig.get_config_var('EXT_SUFFIX'))")

cmake ${CMAKE_ARGS} \
    -DUSE_FFMPEG=ON \
    -DOIIO_BUILD_TOOLS=OFF \
    -DOIIO_BUILD_TESTS=OFF \
    -DUSE_PYTHON=ON \
    -DUSE_OPENCV=OFF \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_BUILD_TYPE=Release \
    -DPYTHON_VERSION=$PY_VER \
    -DPYTHON_MODULE_EXTENSION=${PYTHON_MODULE_EXTENSION} \
    ..

make all -j${CPU_COUNT}

popd
