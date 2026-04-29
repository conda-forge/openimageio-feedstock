@echo on
setlocal enabledelayedexpansion

if "%OIIO_OUTPUT%"=="" (
    echo OIIO_OUTPUT must be set
    exit /b 1
)

set "SOURCE_ROOT=%SRC_DIR%\oiio_src"
set "BUILD_DIR=%SRC_DIR%\build-stage"

if /I "%OIIO_OUTPUT%"=="tools-staged" (
    rem CMake's normal install also records these executables in
    rem lib/cmake/OpenImageIO/OpenImageIOTargets.cmake. This output only needs
    rem the binaries, so copy the staged tools directly.
    if not exist "%LIBRARY_BIN%" (
        mkdir "%LIBRARY_BIN%" || exit /b 1
    )
    copy /Y "%BUILD_DIR%\bin\*.exe" "%LIBRARY_BIN%\" || exit /b 1
    exit /b 0
)

set "MODE_ARGS="
set "PYTHON_ARGS="
if /I "%OIIO_OUTPUT%"=="core-staged" (
    set "MODE_ARGS=-DUSE_PYTHON=OFF"
) else if /I "%OIIO_OUTPUT%"=="python-staged" (
    set "MODE_ARGS=-DUSE_PYTHON=ON"
    set "PYTHON_ARGS=-DPython_EXECUTABLE=%PYTHON% -DPython3_EXECUTABLE=%PYTHON% -DPYTHON_VERSION=%PY_VER% -DPYTHON_SITE_DIR=%SP_DIR%\OpenImageIO"
) else (
    echo Unsupported OIIO_OUTPUT value: %OIIO_OUTPUT%
    exit /b 1
)

cmake -S "%SOURCE_ROOT%" -B "%BUILD_DIR%" -G Ninja ^
    %CMAKE_ARGS% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
    -DCMAKE_INSTALL_INCLUDEDIR=include ^
    -DCMAKE_CXX_FLAGS="%CXXFLAGS%" ^
    -DOpenImageIO_SUPPORTED_RELEASE=ON ^
    -DBUILD_SHARED_LIBS=ON ^
    -DBUILD_DOCS=OFF ^
    -DINSTALL_DOCS=OFF ^
    -DEMBEDPLUGINS=ON ^
    -DOIIO_INTERNALIZE_FMT=OFF ^
    -DOpenImageIO_BUILD_STATIC_UTIL_LIBRARY=OFF ^
    -DOIIO_BUILD_TESTS=OFF ^
    -DBUILD_TESTING=OFF ^
    -DUSE_QT=OFF ^
    -DUSE_EXTERNAL_PUGIXML=OFF ^
    -DENABLE_PNG=ON ^
    -DENABLE_Freetype=ON ^
    -DENABLE_FFmpeg=ON ^
    -DENABLE_GIF=ON ^
    -DENABLE_Libheif=ON ^
    -DENABLE_LibRaw=ON ^
    -DENABLE_OpenJPEG=ON ^
    -DENABLE_WebP=ON ^
    -DENABLE_openjph=ON ^
    -DUSE_JXL=ON ^
    -DENABLE_TBB=ON ^
    -DENABLE_libuhdr=OFF ^
    -DUSE_FFMPEG=ON ^
    -DENABLE_OpenCV=OFF ^
    -DENABLE_OpenVDB=OFF ^
    -DENABLE_Ptex=OFF ^
    -DENABLE_DCMTK=ON ^
    -DUSE_R3DSDK=OFF ^
    -DOIIO_BUILD_TOOLS=ON ^
    -DINSTALL_FONTS=ON ^
    -DENABLE_iconvert=ON ^
    -DENABLE_idiff=ON ^
    -DENABLE_igrep=ON ^
    -DENABLE_iinfo=ON ^
    -DENABLE_maketx=ON ^
    -DENABLE_oiiotool=ON ^
    -DENABLE_INSTALL_iconvert=OFF ^
    -DENABLE_INSTALL_idiff=OFF ^
    -DENABLE_INSTALL_igrep=OFF ^
    -DENABLE_INSTALL_iinfo=OFF ^
    -DENABLE_INSTALL_maketx=OFF ^
    -DENABLE_INSTALL_oiiotool=OFF ^
    -DENABLE_iv=OFF ^
    -DENABLE_testtex=OFF ^
    %MODE_ARGS% ^
    %PYTHON_ARGS% || exit /b 1

if /I "%OIIO_OUTPUT%"=="python-staged" (
    cmake --build "%BUILD_DIR%" --target PyOpenImageIO --parallel %CPU_COUNT% || exit /b 1
) else (
    cmake --build "%BUILD_DIR%" --parallel %CPU_COUNT% || exit /b 1
)

cmake --install "%BUILD_DIR%" || exit /b 1

if exist "%LIBRARY_PREFIX%\share\doc\OpenImageIO" rd /s /q "%LIBRARY_PREFIX%\share\doc\OpenImageIO"

endlocal
