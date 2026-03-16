@echo on

set CXXFLAGS=%CXXFLAGS% -DGIFLIB_MAJOR=5

if not exist build mkdir build
cd build

cmake -G "Ninja" ^
    %CMAKE_ARGS% ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_CXX_FLAGS="%CXXFLAGS%" ^
    -DUSE_FFMPEG=ON ^
    -DOIIO_BUILD_TOOLS=OFF ^
    -DOIIO_BUILD_TESTS=OFF ^
    -DUSE_PYTHON=ON ^
    -DUSE_OPENCV=OFF ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DPYTHON_VERSION=%PY_VER% ^
    -DPython_EXECUTABLE=%PYTHON% ^
    -DPYTHON_SITE_DIR="%LIBRARY_PREFIX%\site-packages" ^
    -DBUILD_MISSING_FMT=OFF ^
    -DINTERNALIZE_FMT=OFF ^
    ..
if errorlevel 1 exit 1

cmake --build . --config Release
if errorlevel 1 exit 1
