#!/bin/bash

export CXXFLAGS="$CXXFLAGS -Wno-deprecated -DGIFLIB_MAJOR=5"

mkdir -vp ${PREFIX}/bin;
mkdir build; cd build;
cmake $SRC_DIR \
	  -DUSE_FFMPEG=ON \
	  -DOIIO_BUILD_TOOLS=OFF \
	  -DOIIO_BUILD_TESTS=OFF \
	  -DUSE_PYTHON=ON \
	  -DUSE_OPENCV=OFF \
	  -DCMAKE_INSTALL_PREFIX=$PREFIX \
	  -DCMAKE_INSTALL_LIBDIR=lib \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DPYTHON_VERSION=$PY_VER \

make all -j${CPU_COUNT}
