#!/bin/bash

export CXXFLAGS="$CXXFLAGS -Wno-deprecated -DGIFLIB_MAJOR=5"

mkdir -vp ${PREFIX}/bin;
mkdir build; cd build;
cmake ${CMAKE_ARGS} $SRC_DIR \
	  -DVERBOSE=1 \
	  -DUSE_FFMPEG=ON \
	  -DOIIO_BUILD_TOOLS=OFF \
	  -DOIIO_BUILD_TESTS=OFF \
	  -DUSE_PYTHON=ON \
	  -DUSE_OPENCV=OFF \
	  -DCMAKE_INSTALL_PREFIX=$PREFIX \
	  -DCMAKE_INSTALL_LIBDIR=lib \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DPYTHON_VERSION=$PY_VER \
	  -DPYTHON_INCLUDE_DIR=$BUILD_PREFIX/include/python3.10 \
	  -DPYTHON_LIBRARIES=$PREFIX/lib/libpython3.10.dylib

make all -j${CPU_COUNT}
