@echo on
setlocal enabledelayedexpansion

if "%OCIO_BUILD_APPS%"=="" set OCIO_BUILD_APPS=OFF
if "%OCIO_BUILD_PYTHON%"=="" set OCIO_BUILD_PYTHON=OFF
if "%OCIO_USE_OIIO_FOR_APPS%"=="" set OCIO_USE_OIIO_FOR_APPS=OFF
if "%CPU_COUNT%"=="" set CPU_COUNT=1

set "BUILD_DIR=%SRC_DIR%\build_ocio"
if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"

if /I "%OCIO_BUILD_PYTHON%"=="ON" (
    set "OCIO_PYTHON_PACKAGE_INSTALL_DIR=%SP_DIR:\=/%"
    set "OCIO_DOC_ARGS=-DOCIO_BUILD_DOCS=ON -DOCIO_PYTHON_VERSION=%PY_VER% -DPython_EXECUTABLE=%PYTHON% -DPYTHON_VARIANT_PATH=!OCIO_PYTHON_PACKAGE_INSTALL_DIR!"
) else (
    set "OCIO_DOC_ARGS=-DOCIO_BUILD_DOCS=OFF"
)

set "OCIO_SIMD_ARGS="
if /I "%target_platform%"=="win-64" (
    set "OCIO_SIMD_ARGS=-DOCIO_USE_SSE2=ON -DOCIO_USE_SSE3=ON -DOCIO_USE_SSSE3=ON -DOCIO_USE_SSE4=ON -DOCIO_USE_SSE42=ON -DOCIO_USE_AVX=ON -DOCIO_USE_AVX2=ON -DOCIO_USE_AVX512=ON -DOCIO_USE_F16C=ON"
)

cmake -S "%SRC_DIR%\ocio_src" -B "%BUILD_DIR%" -G Ninja ^
    %CMAKE_ARGS% ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBUILD_SHARED_LIBS=ON ^
    -DOCIO_BUILD_APPS=%OCIO_BUILD_APPS% ^
    -DOCIO_BUILD_PYTHON=%OCIO_BUILD_PYTHON% ^
    -DOCIO_BUILD_OPENFX=OFF ^
    -DOCIO_BUILD_JAVA=OFF ^
    -DOCIO_BUILD_TESTS=OFF ^
    -DOCIO_BUILD_GPU_TESTS=OFF ^
    -DOCIO_USE_OIIO_FOR_APPS=%OCIO_USE_OIIO_FOR_APPS% ^
    -DOCIO_WARNING_AS_ERROR=OFF ^
    -DOCIO_USE_SIMD=ON ^
    -DOCIO_USE_SOVERSION=ON ^
    -DOCIO_INSTALL_EXT_PACKAGES=NONE ^
    %OCIO_SIMD_ARGS% ^
    %OCIO_DOC_ARGS%
if errorlevel 1 exit /b 1

if /I "%OCIO_BUILD_PYTHON%"=="ON" (
    cmake --build "%BUILD_DIR%" --config Release --target PyOpenColorIO -j%CPU_COUNT%
    if errorlevel 1 exit /b 1
    if not exist "%BUILD_DIR%\docs\build-html" mkdir "%BUILD_DIR%\docs\build-html"
    cmake --install "%BUILD_DIR%" --config Release
) else (
    cmake --build "%BUILD_DIR%" --config Release --target install -j%CPU_COUNT%
)
if errorlevel 1 exit /b 1

if /I "%OCIO_BUILD_APPS%"=="ON" goto prune
if /I "%OCIO_BUILD_PYTHON%"=="ON" goto prune
goto done

:prune
if exist "%LIBRARY_PREFIX%\include\OpenColorIO" rd /s /q "%LIBRARY_PREFIX%\include\OpenColorIO"
if exist "%LIBRARY_PREFIX%\lib\cmake\OpenColorIO" rd /s /q "%LIBRARY_PREFIX%\lib\cmake\OpenColorIO"
del /f /q "%LIBRARY_LIB%\OpenColorIO*.lib" 2>nul
del /f /q "%LIBRARY_BIN%\OpenColorIO*.dll" 2>nul
del /f /q "%LIBRARY_PREFIX%\lib\pkgconfig\OpenColorIO*.pc" 2>nul
if exist "%LIBRARY_PREFIX%\share\doc\OpenColorIO" rd /s /q "%LIBRARY_PREFIX%\share\doc\OpenColorIO"

:done
endlocal
