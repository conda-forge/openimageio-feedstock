#!/bin/bash
set -ex

cmake --install ./build --prefix=$PREFIX

# remove python stuff from here.
rm -rf $SP_DIR/OpenImageIO
