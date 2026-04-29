@echo on

call :ocio_help ocioarchive --help || exit /b 1
call :ocio_help ociobakelut --help || exit /b 1
ociocpuinfo || exit /b 1
call :ocio_help ociomergeconfigs --help || exit /b 1

(echo Version 1& echo From 0 1& echo Length 2& echo Components 1& echo {& echo 0.0& echo 1.0& echo }) > "%TEMP%\ocio_identity.spi1d"
ociochecklut "%TEMP%\ocio_identity.spi1d" 0.5 0.5 0.5 || exit /b 1

rem A TIFF round-trip proves OCIO found the OIIO backend rather than
rem silently falling back to the OpenEXR-only image backend.
ociolutimage --generate --output "%TEMP%\ocio_lutimage.tif" || exit /b 1
if not exist "%TEMP%\ocio_lutimage.tif" exit /b 1
ocioconvert --lut "%TEMP%\ocio_identity.spi1d" "%TEMP%\ocio_lutimage.tif" "%TEMP%\ocio_lutimage.exr" || exit /b 1
if not exist "%TEMP%\ocio_lutimage.exr" exit /b 1

exit /b 0

:ocio_help
%* >nul 2>&1
if %ERRORLEVEL% LEQ 1 exit /b 0
exit /b %ERRORLEVEL%
