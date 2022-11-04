#!/bin/bash

# suppress warnings for clang..
if [ $(uname) == "Darwin" ]; then
  additional_cxx_flags='-Wno-unused-private-field -Wno-error=unused-but-set-variable'
  echo "--> [START] Checking if stat.h files contains UTIME_OMIT.."
  find /Applications/Xcode_13.2.1.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs -type f -name 'stat.h' -exec grep -H --color -e UTIME {} \;
  echo "--> [END] "
# and gcc
elif [ $(uname) == "Linux" ]; then
  additional_cxx_flags='-Wno-deprecated -Wno-unused-variable -Wno-unused-but-set-variable'
else
  additional_cxx_flags=''
fi

export CXXFLAGS="$CXXFLAGS $additional_cxx_flags -DGIFLIB_MAJOR=5"

PY_MAJ_MIN_VER=$(echo $PY_VER | awk -F '.' '{print $1"."$2}')

mkdir -vp ${PREFIX}/bin;
mkdir build; cd build;
cmake ${CMAKE_ARGS} $SRC_DIR \
  -DVERBOSE=1 \
  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
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
  -DUSE_STD_REGEX_EXITCODE__TRYRUN_OUTPUT='' \
  -DCMAKE_CXX_FLAGS="$CXXFLAGS" \
  -DGIF_INCLUDE_DIR=$PREFIX/include \
  -DGIF_INCLUDE_DIRS=$PREFIX/include \
  -DJPEG_INCLUDE_DIR=$PREFIX/include \
  -DJPEG_INCLUDE_DIRS=$PREFIX/include \
  -DCMAKE_FIND_FRAMEWORK=LAST

make all -j${CPU_COUNT}
