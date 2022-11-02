#!/bin/bash

export CXXFLAGS="$CXXFLAGS -Wno-deprecated -Wno-error=unused-but-set-variable -DGIFLIB_MAJOR=5"
PY_MAJ_MIN_VER=$(echo $PY_VER | cut -d '.' -f1 -f2)

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
	  -DPYTHON_INCLUDE_DIR=$BUILD_PREFIX/include/python$PY_MAJ_MIN_VER \
	  -DPYTHON_LIBRARIES=$PREFIX/lib/libpython${PY_MAJ_MIN_VER}.dylib \
	  -DUSE_STD_REGEX_EXITCODE=0 \
	  -DUSE_STD_REGEX_EXITCODE__TRYRUN_OUTPUT=''

make all -j${CPU_COUNT}
