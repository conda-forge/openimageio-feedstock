#!/usr/bin/env bash
set -euo pipefail

# OCIO --help commonly exits 1; only treat >=2 as failure.
_h() { "$@" >/dev/null 2>&1 || [ $? -eq 1 ]; }

# Minimal valid 1D LUT used by CLI smoke tests.
printf 'Version 1\nFrom 0 1\nLength 2\nComponents 1\n{\n0.0\n1.0\n}\n' > /tmp/ocio_identity.spi1d

_h ocioarchive --help
_h ociobakelut --help
ociochecklut /tmp/ocio_identity.spi1d 0.5 0.5 0.5
ociocpuinfo
_h ociomergeconfigs --help

# A TIFF round-trip proves OCIO found the OIIO backend rather than
# silently falling back to the OpenEXR-only image backend.
ociolutimage --generate --output /tmp/ocio_lutimage.tif
test -f /tmp/ocio_lutimage.tif
ocioconvert --lut /tmp/ocio_identity.spi1d /tmp/ocio_lutimage.tif /tmp/ocio_lutimage.exr
test -f /tmp/ocio_lutimage.exr
test -x "$PREFIX/bin/ociodisplay"

# Verify OpenGL support was compiled into GPU-capable tools.
# ociochecklut --gpu exits 1 in two cases:
#   (a) "Compiled without OpenGL support" -> bad build, fail
#   (b) EGL init failure in headless CI     -> runtime env, allowed
case "${target_platform:-}" in
  linux-*)
    ociochecklut --gpu /tmp/ocio_identity.spi1d 0.5 0.5 0.5 >/tmp/ocio_gpu_check.txt 2>&1 || true
    cat /tmp/ocio_gpu_check.txt
    ! grep -Fq "Compiled without OpenGL support" /tmp/ocio_gpu_check.txt
    ;;
esac
