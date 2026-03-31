@echo on
setlocal enabledelayedexpansion

if "%OIIO_BUILD_PYTHON%"=="" set OIIO_BUILD_PYTHON=1

set CXXFLAGS=%CXXFLAGS% -DGIFLIB_MAJOR=5

if not exist "%PREFIX%\bin" mkdir "%PREFIX%\bin"

if not exist build mkdir build
pushd build

set USE_PYTHON=OFF
set PYTHON_ARGS=
if "%OIIO_BUILD_PYTHON%"=="1" (
    set USE_PYTHON=ON
    set PYTHON_ARGS=-DPYTHON_VERSION=%PY_VER% -DPython_EXECUTABLE="%PYTHON%"
)

cmake -G "Ninja" ^
    %CMAKE_ARGS% ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_CXX_FLAGS="%CXXFLAGS%" ^
    -DUSE_FFMPEG=ON ^
    -DOIIO_BUILD_TOOLS=OFF ^
    -DOIIO_BUILD_TESTS=OFF ^
    -DUSE_PYTHON=%USE_PYTHON% ^
    -DUSE_OPENCV=OFF ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DPYTHON_SITE_DIR="%SP_DIR%\OpenImageIO" ^
    -DBUILD_MISSING_FMT=OFF ^
    -DINTERNALIZE_FMT=OFF ^
    %PYTHON_ARGS% ^
    ..
if errorlevel 1 exit 1

cmake --build . --config Release
if errorlevel 1 exit 1

cmake --install . --prefix "%LIBRARY_PREFIX%"
if errorlevel 1 exit 1

popd

if exist "%LIBRARY_PREFIX%\share\doc\OpenImageIO" rd /s /q "%LIBRARY_PREFIX%\share\doc\OpenImageIO"
