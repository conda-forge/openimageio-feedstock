#!/bin/bash
set -ex

if [[ "$target_platform" != "win-64" ]]; then
  cmake --install ./build --prefix=$PREFIX
else
  cmake --install ./build --prefix=$LIBRARY_PREFIX
fi

# remove python stuff from here.
rm -rf $SP_DIR/OpenImageIO
