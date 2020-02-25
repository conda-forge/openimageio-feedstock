cd build;
make install -j${CPU_COUNT};

# remove python stuff from here.
rm -rf $PREFIX/lib/python*