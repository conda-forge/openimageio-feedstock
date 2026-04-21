@echo on
setlocal enabledelayedexpansion

if "%OIIO_OUTPUT%"=="" set OIIO_OUTPUT=core
if "%CPU_COUNT%"=="" set CPU_COUNT=1

set "SOURCE_ROOT=%SRC_DIR%\oiio_src"
set "BUILD_DIR=%SRC_DIR%\build-%OIIO_OUTPUT%"
set "CXXFLAGS=%CXXFLAGS% -DGIFLIB_MAJOR=5"

if not exist "%SOURCE_ROOT%\CMakeLists.txt" (
    echo Could not find OpenImageIO source root at %SOURCE_ROOT%
    exit /b 1
)

if /I "%OIIO_OUTPUT%"=="core" (
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
        -DOIIO_BUILD_TOOLS=OFF ^
        -DINSTALL_FONTS=ON ^
        -DUSE_PYTHON=OFF ^
        -DENABLE_iv=OFF ^
        -DENABLE_testtex=OFF
) else if /I "%OIIO_OUTPUT%"=="tools" (
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
        -DINSTALL_FONTS=OFF ^
        -DUSE_PYTHON=OFF ^
        -DENABLE_iconvert=ON ^
        -DENABLE_idiff=ON ^
        -DENABLE_igrep=ON ^
        -DENABLE_iinfo=ON ^
        -DENABLE_maketx=ON ^
        -DENABLE_oiiotool=ON ^
        -DENABLE_iv=OFF ^
        -DENABLE_testtex=OFF
) else if /I "%OIIO_OUTPUT%"=="python" (
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
        -DOIIO_BUILD_TOOLS=OFF ^
        -DINSTALL_FONTS=OFF ^
        -DUSE_PYTHON=ON ^
        -DENABLE_iv=OFF ^
        -DENABLE_testtex=OFF ^
        -DPython_EXECUTABLE="%PYTHON%" ^
        -DPython3_EXECUTABLE="%PYTHON%" ^
        -DPYTHON_VERSION=%PY_VER% ^
        -DPYTHON_SITE_DIR="%SP_DIR%\OpenImageIO"
) else (
    echo Unsupported OIIO_OUTPUT value: %OIIO_OUTPUT%
    exit /b 1
)
if errorlevel 1 exit /b 1

cmake --build "%BUILD_DIR%" --parallel %CPU_COUNT%
if errorlevel 1 exit /b 1

cmake --install "%BUILD_DIR%"
if errorlevel 1 exit /b 1

if exist "%LIBRARY_PREFIX%\share\doc\OpenImageIO" rd /s /q "%LIBRARY_PREFIX%\share\doc\OpenImageIO"

if /I "%OIIO_OUTPUT%"=="tools" goto prune
if /I "%OIIO_OUTPUT%"=="python" goto prune
goto done

:prune
if exist "%LIBRARY_PREFIX%\include\OpenImageIO" rd /s /q "%LIBRARY_PREFIX%\include\OpenImageIO"
if exist "%LIBRARY_PREFIX%\lib\cmake\OpenImageIO" rd /s /q "%LIBRARY_PREFIX%\lib\cmake\OpenImageIO"
del /f /q "%LIBRARY_LIB%\OpenImageIO*.lib" 2>nul
del /f /q "%LIBRARY_BIN%\OpenImageIO*.dll" 2>nul
del /f /q "%LIBRARY_BIN%\OpenImageIO_Util*.dll" 2>nul
del /f /q "%LIBRARY_PREFIX%\lib\pkgconfig\OpenImageIO.pc" 2>nul
if exist "%LIBRARY_PREFIX%\share\fonts\OpenImageIO" rd /s /q "%LIBRARY_PREFIX%\share\fonts\OpenImageIO"

:done
endlocal
