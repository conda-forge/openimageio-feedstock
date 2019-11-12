#!/bin/bash

mkdir build; cd build;
cmake $SRC_DIR \
	  -DUSE_FFMPEG=ON \
	  -DOIIO_BUILD_TOOLS=OFF \
	  -DOIIO_BUILD_TESTS=OFF \
	  -DUSE_PYTHON=OFF \
	  -DUSE_OPENCV=OFF \
	  -DCMAKE_INSTALL_PREFIX=$PREFIX \
	  -DCMAKE_SYSTEM_IGNORE_PATH=/usr/lib \
	  -DCMAKE_INSTALL_LIBDIR=lib \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DCMAKE_CXX_FLAGS="-DGIFLIB_MAJOR=5 -Wno-deprecated" # Hack for OS X build

make install -j${CPU_COUNT}
