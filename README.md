About openimageio-feedstock
===========================

Feedstock license: [BSD-3-Clause](https://github.com/conda-forge/openimageio-feedstock/blob/main/LICENSE.txt)


About openimageio
-----------------

Home: https://opencolorio.org/

Package license: BSD-3-Clause

Summary: OpenColorIO core C++ library and headers

Development: https://github.com/AcademySoftwareFoundation/OpenColorIO

Documentation: https://opencolorio.readthedocs.io/

OpenImageIO is a toolset for reading, writing, and manipulating image files of any image file format relevant to VFX / animation via a format-agnostic API with a feature set, scalability, and robustness needed for feature film production.

The primary target audience for OIIO is VFX studios and developers of tools such as renderers, compositors, viewers, and other image-related software you'd find in a production pipeline.

OpenImageIO consists of:
- Simple but powerful ImageInput and ImageOutput APIs that provide an abstraction for reading and writing image files of nearly any format, without the calling application needing to know any of the details of these file formats, and indeed without the calling application needing to be aware of which formats are available.
- A library that manages subclasses of ImageInput and ImageOutput that implement I/O from specific file formats, with each file format's implementation stored as a plug-in. Therefore, an application using OpenImageIO's APIs can read and write any image file for which a plugin can be found at runtime.
- Plugins implementing I/O for several popular image file formats, including TIFF, JPEG/JFIF, JPEG XL, OpenEXR, PNG, HDR/RGBE, ICO, BMP, Targa, JPEG-2000, RMan Zfile, FITS, DDS, Softimage PIC, PNM, DPX, Cineon, IFF, OpenVDB, Ptex, Photoshop PSD, Wavefront RLA, SGI, WebP, GIF, DICOM, HEIF/HEIC/AVIF, many "RAW" digital camera formats, and a variety of movie formats (readable as individual frames). More are being developed all the time.
- Several command line image tools based on these classes, including oiiotool (command-line format conversion and image processing), iinfo (print detailed info about images), iconvert (convert among formats, data types, or modify metadata), idiff (compare images), igrep (search images for matching metadata), and iv (an image viewer). Because these tools are based on ImageInput/ImageOutput, they work with any image formats for which ImageIO plugins are available.
- An ImageCache class that transparently manages a cache so that it can access truly vast amounts of image data (tens of thousands of image files totaling multiple TB) very efficiently using only a tiny amount (tens of megabytes at most) of runtime memory.
- A TextureSystem class that provides filtered MIP-map texture lookups, atop the nice caching behavior of ImageCache. This is used in commercial renderers and has been used on many large VFX and animated films.
- ImageBuf and ImageBufAlgo functions -- a simple class for storing and manipulating whole images in memory, and a collection of the most useful computations you might want to do involving those images, including many image processing operations.
- Python bindings for all of the major APIs.

About opencolorio-tools
-----------------------

Home: https://opencolorio.org/

Package license: BSD-3-Clause

Summary: OpenColorIO command-line tools built with OpenImageIO integration

Development: https://github.com/AcademySoftwareFoundation/OpenColorIO

Documentation: https://opencolorio.readthedocs.io/

OpenImageIO is a toolset for reading, writing, and manipulating image files of any image file format relevant to VFX / animation via a format-agnostic API with a feature set, scalability, and robustness needed for feature film production.

The primary target audience for OIIO is VFX studios and developers of tools such as renderers, compositors, viewers, and other image-related software you'd find in a production pipeline.

OpenImageIO consists of:
- Simple but powerful ImageInput and ImageOutput APIs that provide an abstraction for reading and writing image files of nearly any format, without the calling application needing to know any of the details of these file formats, and indeed without the calling application needing to be aware of which formats are available.
- A library that manages subclasses of ImageInput and ImageOutput that implement I/O from specific file formats, with each file format's implementation stored as a plug-in. Therefore, an application using OpenImageIO's APIs can read and write any image file for which a plugin can be found at runtime.
- Plugins implementing I/O for several popular image file formats, including TIFF, JPEG/JFIF, JPEG XL, OpenEXR, PNG, HDR/RGBE, ICO, BMP, Targa, JPEG-2000, RMan Zfile, FITS, DDS, Softimage PIC, PNM, DPX, Cineon, IFF, OpenVDB, Ptex, Photoshop PSD, Wavefront RLA, SGI, WebP, GIF, DICOM, HEIF/HEIC/AVIF, many "RAW" digital camera formats, and a variety of movie formats (readable as individual frames). More are being developed all the time.
- Several command line image tools based on these classes, including oiiotool (command-line format conversion and image processing), iinfo (print detailed info about images), iconvert (convert among formats, data types, or modify metadata), idiff (compare images), igrep (search images for matching metadata), and iv (an image viewer). Because these tools are based on ImageInput/ImageOutput, they work with any image formats for which ImageIO plugins are available.
- An ImageCache class that transparently manages a cache so that it can access truly vast amounts of image data (tens of thousands of image files totaling multiple TB) very efficiently using only a tiny amount (tens of megabytes at most) of runtime memory.
- A TextureSystem class that provides filtered MIP-map texture lookups, atop the nice caching behavior of ImageCache. This is used in commercial renderers and has been used on many large VFX and animated films.
- ImageBuf and ImageBufAlgo functions -- a simple class for storing and manipulating whole images in memory, and a collection of the most useful computations you might want to do involving those images, including many image processing operations.
- Python bindings for all of the major APIs.

About openimageio
-----------------

Home: https://openimageio.org/

Package license: Apache-2.0

Summary: Libraries, tools, and Python bindings for reading, writing, and processing images

Development: https://github.com/AcademySoftwareFoundation/OpenImageIO

Documentation: https://openimageio.readthedocs.io/

OpenImageIO is a toolset for reading, writing, and manipulating image files of any image file format relevant to VFX / animation via a format-agnostic API with a feature set, scalability, and robustness needed for feature film production.

The primary target audience for OIIO is VFX studios and developers of tools such as renderers, compositors, viewers, and other image-related software you'd find in a production pipeline.

OpenImageIO consists of:
- Simple but powerful ImageInput and ImageOutput APIs that provide an abstraction for reading and writing image files of nearly any format, without the calling application needing to know any of the details of these file formats, and indeed without the calling application needing to be aware of which formats are available.
- A library that manages subclasses of ImageInput and ImageOutput that implement I/O from specific file formats, with each file format's implementation stored as a plug-in. Therefore, an application using OpenImageIO's APIs can read and write any image file for which a plugin can be found at runtime.
- Plugins implementing I/O for several popular image file formats, including TIFF, JPEG/JFIF, JPEG XL, OpenEXR, PNG, HDR/RGBE, ICO, BMP, Targa, JPEG-2000, RMan Zfile, FITS, DDS, Softimage PIC, PNM, DPX, Cineon, IFF, OpenVDB, Ptex, Photoshop PSD, Wavefront RLA, SGI, WebP, GIF, DICOM, HEIF/HEIC/AVIF, many "RAW" digital camera formats, and a variety of movie formats (readable as individual frames). More are being developed all the time.
- Several command line image tools based on these classes, including oiiotool (command-line format conversion and image processing), iinfo (print detailed info about images), iconvert (convert among formats, data types, or modify metadata), idiff (compare images), igrep (search images for matching metadata), and iv (an image viewer). Because these tools are based on ImageInput/ImageOutput, they work with any image formats for which ImageIO plugins are available.
- An ImageCache class that transparently manages a cache so that it can access truly vast amounts of image data (tens of thousands of image files totaling multiple TB) very efficiently using only a tiny amount (tens of megabytes at most) of runtime memory.
- A TextureSystem class that provides filtered MIP-map texture lookups, atop the nice caching behavior of ImageCache. This is used in commercial renderers and has been used on many large VFX and animated films.
- ImageBuf and ImageBufAlgo functions -- a simple class for storing and manipulating whole images in memory, and a collection of the most useful computations you might want to do involving those images, including many image processing operations.
- Python bindings for all of the major APIs.

About openimageio-tools
-----------------------

Home: https://openimageio.org/

Package license: Apache-2.0

Summary: Libraries, tools, and Python bindings for reading, writing, and processing images

Development: https://github.com/AcademySoftwareFoundation/OpenImageIO

Documentation: https://openimageio.readthedocs.io/

OpenImageIO is a toolset for reading, writing, and manipulating image files of any image file format relevant to VFX / animation via a format-agnostic API with a feature set, scalability, and robustness needed for feature film production.

The primary target audience for OIIO is VFX studios and developers of tools such as renderers, compositors, viewers, and other image-related software you'd find in a production pipeline.

OpenImageIO consists of:
- Simple but powerful ImageInput and ImageOutput APIs that provide an abstraction for reading and writing image files of nearly any format, without the calling application needing to know any of the details of these file formats, and indeed without the calling application needing to be aware of which formats are available.
- A library that manages subclasses of ImageInput and ImageOutput that implement I/O from specific file formats, with each file format's implementation stored as a plug-in. Therefore, an application using OpenImageIO's APIs can read and write any image file for which a plugin can be found at runtime.
- Plugins implementing I/O for several popular image file formats, including TIFF, JPEG/JFIF, JPEG XL, OpenEXR, PNG, HDR/RGBE, ICO, BMP, Targa, JPEG-2000, RMan Zfile, FITS, DDS, Softimage PIC, PNM, DPX, Cineon, IFF, OpenVDB, Ptex, Photoshop PSD, Wavefront RLA, SGI, WebP, GIF, DICOM, HEIF/HEIC/AVIF, many "RAW" digital camera formats, and a variety of movie formats (readable as individual frames). More are being developed all the time.
- Several command line image tools based on these classes, including oiiotool (command-line format conversion and image processing), iinfo (print detailed info about images), iconvert (convert among formats, data types, or modify metadata), idiff (compare images), igrep (search images for matching metadata), and iv (an image viewer). Because these tools are based on ImageInput/ImageOutput, they work with any image formats for which ImageIO plugins are available.
- An ImageCache class that transparently manages a cache so that it can access truly vast amounts of image data (tens of thousands of image files totaling multiple TB) very efficiently using only a tiny amount (tens of megabytes at most) of runtime memory.
- A TextureSystem class that provides filtered MIP-map texture lookups, atop the nice caching behavior of ImageCache. This is used in commercial renderers and has been used on many large VFX and animated films.
- ImageBuf and ImageBufAlgo functions -- a simple class for storing and manipulating whole images in memory, and a collection of the most useful computations you might want to do involving those images, including many image processing operations.
- Python bindings for all of the major APIs.

About py-openimageio
--------------------

Home: https://openimageio.org/

Package license: Apache-2.0

Summary: Libraries, tools, and Python bindings for reading, writing, and processing images

Development: https://github.com/AcademySoftwareFoundation/OpenImageIO

Documentation: https://openimageio.readthedocs.io/

OpenImageIO is a toolset for reading, writing, and manipulating image files of any image file format relevant to VFX / animation via a format-agnostic API with a feature set, scalability, and robustness needed for feature film production.

The primary target audience for OIIO is VFX studios and developers of tools such as renderers, compositors, viewers, and other image-related software you'd find in a production pipeline.

OpenImageIO consists of:
- Simple but powerful ImageInput and ImageOutput APIs that provide an abstraction for reading and writing image files of nearly any format, without the calling application needing to know any of the details of these file formats, and indeed without the calling application needing to be aware of which formats are available.
- A library that manages subclasses of ImageInput and ImageOutput that implement I/O from specific file formats, with each file format's implementation stored as a plug-in. Therefore, an application using OpenImageIO's APIs can read and write any image file for which a plugin can be found at runtime.
- Plugins implementing I/O for several popular image file formats, including TIFF, JPEG/JFIF, JPEG XL, OpenEXR, PNG, HDR/RGBE, ICO, BMP, Targa, JPEG-2000, RMan Zfile, FITS, DDS, Softimage PIC, PNM, DPX, Cineon, IFF, OpenVDB, Ptex, Photoshop PSD, Wavefront RLA, SGI, WebP, GIF, DICOM, HEIF/HEIC/AVIF, many "RAW" digital camera formats, and a variety of movie formats (readable as individual frames). More are being developed all the time.
- Several command line image tools based on these classes, including oiiotool (command-line format conversion and image processing), iinfo (print detailed info about images), iconvert (convert among formats, data types, or modify metadata), idiff (compare images), igrep (search images for matching metadata), and iv (an image viewer). Because these tools are based on ImageInput/ImageOutput, they work with any image formats for which ImageIO plugins are available.
- An ImageCache class that transparently manages a cache so that it can access truly vast amounts of image data (tens of thousands of image files totaling multiple TB) very efficiently using only a tiny amount (tens of megabytes at most) of runtime memory.
- A TextureSystem class that provides filtered MIP-map texture lookups, atop the nice caching behavior of ImageCache. This is used in commercial renderers and has been used on many large VFX and animated films.
- ImageBuf and ImageBufAlgo functions -- a simple class for storing and manipulating whole images in memory, and a collection of the most useful computations you might want to do involving those images, including many image processing operations.
- Python bindings for all of the major APIs.

About pyopencolorio
-------------------

Home: https://opencolorio.org/

Package license: BSD-3-Clause

Summary: Python bindings for OpenColorIO

Development: https://github.com/AcademySoftwareFoundation/OpenColorIO

Documentation: https://opencolorio.readthedocs.io/

OpenImageIO is a toolset for reading, writing, and manipulating image files of any image file format relevant to VFX / animation via a format-agnostic API with a feature set, scalability, and robustness needed for feature film production.

The primary target audience for OIIO is VFX studios and developers of tools such as renderers, compositors, viewers, and other image-related software you'd find in a production pipeline.

OpenImageIO consists of:
- Simple but powerful ImageInput and ImageOutput APIs that provide an abstraction for reading and writing image files of nearly any format, without the calling application needing to know any of the details of these file formats, and indeed without the calling application needing to be aware of which formats are available.
- A library that manages subclasses of ImageInput and ImageOutput that implement I/O from specific file formats, with each file format's implementation stored as a plug-in. Therefore, an application using OpenImageIO's APIs can read and write any image file for which a plugin can be found at runtime.
- Plugins implementing I/O for several popular image file formats, including TIFF, JPEG/JFIF, JPEG XL, OpenEXR, PNG, HDR/RGBE, ICO, BMP, Targa, JPEG-2000, RMan Zfile, FITS, DDS, Softimage PIC, PNM, DPX, Cineon, IFF, OpenVDB, Ptex, Photoshop PSD, Wavefront RLA, SGI, WebP, GIF, DICOM, HEIF/HEIC/AVIF, many "RAW" digital camera formats, and a variety of movie formats (readable as individual frames). More are being developed all the time.
- Several command line image tools based on these classes, including oiiotool (command-line format conversion and image processing), iinfo (print detailed info about images), iconvert (convert among formats, data types, or modify metadata), idiff (compare images), igrep (search images for matching metadata), and iv (an image viewer). Because these tools are based on ImageInput/ImageOutput, they work with any image formats for which ImageIO plugins are available.
- An ImageCache class that transparently manages a cache so that it can access truly vast amounts of image data (tens of thousands of image files totaling multiple TB) very efficiently using only a tiny amount (tens of megabytes at most) of runtime memory.
- A TextureSystem class that provides filtered MIP-map texture lookups, atop the nice caching behavior of ImageCache. This is used in commercial renderers and has been used on many large VFX and animated films.
- ImageBuf and ImageBufAlgo functions -- a simple class for storing and manipulating whole images in memory, and a collection of the most useful computations you might want to do involving those images, including many image processing operations.
- Python bindings for all of the major APIs.

Current build status
====================


<table>
    
  <tr>
    <td>Azure</td>
    <td>
      <details>
        <summary>
          <a href="https://dev.azure.com/conda-forge/feedstock-builds/_build/latest?definitionId=2634&branchName=main">
            <img src="https://dev.azure.com/conda-forge/feedstock-builds/_apis/build/status/openimageio-feedstock?branchName=main">
          </a>
        </summary>
        <table>
          <thead><tr><th>Variant</th><th>Status</th></tr></thead>
          <tbody><tr>
              <td>linux_64</td>
              <td>
                <a href="https://dev.azure.com/conda-forge/feedstock-builds/_build/latest?definitionId=2634&branchName=main">
                  <img src="https://dev.azure.com/conda-forge/feedstock-builds/_apis/build/status/openimageio-feedstock?branchName=main&jobName=linux&configuration=linux%20linux_64_" alt="variant">
                </a>
              </td>
            </tr><tr>
              <td>linux_aarch64</td>
              <td>
                <a href="https://dev.azure.com/conda-forge/feedstock-builds/_build/latest?definitionId=2634&branchName=main">
                  <img src="https://dev.azure.com/conda-forge/feedstock-builds/_apis/build/status/openimageio-feedstock?branchName=main&jobName=linux&configuration=linux%20linux_aarch64_" alt="variant">
                </a>
              </td>
            </tr><tr>
              <td>linux_ppc64le</td>
              <td>
                <a href="https://dev.azure.com/conda-forge/feedstock-builds/_build/latest?definitionId=2634&branchName=main">
                  <img src="https://dev.azure.com/conda-forge/feedstock-builds/_apis/build/status/openimageio-feedstock?branchName=main&jobName=linux&configuration=linux%20linux_ppc64le_" alt="variant">
                </a>
              </td>
            </tr><tr>
              <td>osx_64</td>
              <td>
                <a href="https://dev.azure.com/conda-forge/feedstock-builds/_build/latest?definitionId=2634&branchName=main">
                  <img src="https://dev.azure.com/conda-forge/feedstock-builds/_apis/build/status/openimageio-feedstock?branchName=main&jobName=osx&configuration=osx%20osx_64_" alt="variant">
                </a>
              </td>
            </tr><tr>
              <td>osx_arm64</td>
              <td>
                <a href="https://dev.azure.com/conda-forge/feedstock-builds/_build/latest?definitionId=2634&branchName=main">
                  <img src="https://dev.azure.com/conda-forge/feedstock-builds/_apis/build/status/openimageio-feedstock?branchName=main&jobName=osx&configuration=osx%20osx_arm64_" alt="variant">
                </a>
              </td>
            </tr><tr>
              <td>win_64</td>
              <td>
                <a href="https://dev.azure.com/conda-forge/feedstock-builds/_build/latest?definitionId=2634&branchName=main">
                  <img src="https://dev.azure.com/conda-forge/feedstock-builds/_apis/build/status/openimageio-feedstock?branchName=main&jobName=win&configuration=win%20win_64_" alt="variant">
                </a>
              </td>
            </tr>
          </tbody>
        </table>
      </details>
    </td>
  </tr>
</table>

Current release info
====================

| Name | Downloads | Version | Platforms |
| --- | --- | --- | --- |
| [![Conda Recipe](https://img.shields.io/badge/recipe-opencolorio-green.svg)](https://anaconda.org/conda-forge/opencolorio) | [![Conda Downloads](https://img.shields.io/conda/dn/conda-forge/opencolorio.svg)](https://anaconda.org/conda-forge/opencolorio) | [![Conda Version](https://img.shields.io/conda/vn/conda-forge/opencolorio.svg)](https://anaconda.org/conda-forge/opencolorio) | [![Conda Platforms](https://img.shields.io/conda/pn/conda-forge/opencolorio.svg)](https://anaconda.org/conda-forge/opencolorio) |
| [![Conda Recipe](https://img.shields.io/badge/recipe-opencolorio--tools-green.svg)](https://anaconda.org/conda-forge/opencolorio-tools) | [![Conda Downloads](https://img.shields.io/conda/dn/conda-forge/opencolorio-tools.svg)](https://anaconda.org/conda-forge/opencolorio-tools) | [![Conda Version](https://img.shields.io/conda/vn/conda-forge/opencolorio-tools.svg)](https://anaconda.org/conda-forge/opencolorio-tools) | [![Conda Platforms](https://img.shields.io/conda/pn/conda-forge/opencolorio-tools.svg)](https://anaconda.org/conda-forge/opencolorio-tools) |
| [![Conda Recipe](https://img.shields.io/badge/recipe-openimageio-green.svg)](https://anaconda.org/conda-forge/openimageio) | [![Conda Downloads](https://img.shields.io/conda/dn/conda-forge/openimageio.svg)](https://anaconda.org/conda-forge/openimageio) | [![Conda Version](https://img.shields.io/conda/vn/conda-forge/openimageio.svg)](https://anaconda.org/conda-forge/openimageio) | [![Conda Platforms](https://img.shields.io/conda/pn/conda-forge/openimageio.svg)](https://anaconda.org/conda-forge/openimageio) |
| [![Conda Recipe](https://img.shields.io/badge/recipe-openimageio--tools-green.svg)](https://anaconda.org/conda-forge/openimageio-tools) | [![Conda Downloads](https://img.shields.io/conda/dn/conda-forge/openimageio-tools.svg)](https://anaconda.org/conda-forge/openimageio-tools) | [![Conda Version](https://img.shields.io/conda/vn/conda-forge/openimageio-tools.svg)](https://anaconda.org/conda-forge/openimageio-tools) | [![Conda Platforms](https://img.shields.io/conda/pn/conda-forge/openimageio-tools.svg)](https://anaconda.org/conda-forge/openimageio-tools) |
| [![Conda Recipe](https://img.shields.io/badge/recipe-py--openimageio-green.svg)](https://anaconda.org/conda-forge/py-openimageio) | [![Conda Downloads](https://img.shields.io/conda/dn/conda-forge/py-openimageio.svg)](https://anaconda.org/conda-forge/py-openimageio) | [![Conda Version](https://img.shields.io/conda/vn/conda-forge/py-openimageio.svg)](https://anaconda.org/conda-forge/py-openimageio) | [![Conda Platforms](https://img.shields.io/conda/pn/conda-forge/py-openimageio.svg)](https://anaconda.org/conda-forge/py-openimageio) |
| [![Conda Recipe](https://img.shields.io/badge/recipe-pyopencolorio-green.svg)](https://anaconda.org/conda-forge/pyopencolorio) | [![Conda Downloads](https://img.shields.io/conda/dn/conda-forge/pyopencolorio.svg)](https://anaconda.org/conda-forge/pyopencolorio) | [![Conda Version](https://img.shields.io/conda/vn/conda-forge/pyopencolorio.svg)](https://anaconda.org/conda-forge/pyopencolorio) | [![Conda Platforms](https://img.shields.io/conda/pn/conda-forge/pyopencolorio.svg)](https://anaconda.org/conda-forge/pyopencolorio) |

Installing openimageio
======================

Installing `openimageio` from the `conda-forge` channel can be achieved by adding `conda-forge` to your channels with:

```
conda config --add channels conda-forge
conda config --set channel_priority strict
```

Once the `conda-forge` channel has been enabled, `opencolorio, opencolorio-tools, openimageio, openimageio-tools, py-openimageio, pyopencolorio` can be installed with `conda`:

```
conda install opencolorio opencolorio-tools openimageio openimageio-tools py-openimageio pyopencolorio
```

or with `mamba`:

```
mamba install opencolorio opencolorio-tools openimageio openimageio-tools py-openimageio pyopencolorio
```

It is possible to list all of the versions of `opencolorio` available on your platform with `conda`:

```
conda search opencolorio --channel conda-forge
```

or with `mamba`:

```
mamba search opencolorio --channel conda-forge
```

Alternatively, `mamba repoquery` may provide more information:

```
# Search all versions available on your platform:
mamba repoquery search opencolorio --channel conda-forge

# List packages depending on `opencolorio`:
mamba repoquery whoneeds opencolorio --channel conda-forge

# List dependencies of `opencolorio`:
mamba repoquery depends opencolorio --channel conda-forge
```


About conda-forge
=================

[![Powered by
NumFOCUS](https://img.shields.io/badge/powered%20by-NumFOCUS-orange.svg?style=flat&colorA=E1523D&colorB=007D8A)](https://numfocus.org)

conda-forge is a community-led conda channel of installable packages.
In order to provide high-quality builds, the process has been automated into the
conda-forge GitHub organization. The conda-forge organization contains one repository
for each of the installable packages. Such a repository is known as a *feedstock*.

A feedstock is made up of a conda recipe (the instructions on what and how to build
the package) and the necessary configurations for automatic building using freely
available continuous integration services. Thanks to the awesome service provided by
[Azure](https://azure.microsoft.com/en-us/services/devops/), [GitHub](https://github.com/),
[CircleCI](https://circleci.com/), [AppVeyor](https://www.appveyor.com/),
[Drone](https://cloud.drone.io/welcome), and [TravisCI](https://travis-ci.com/)
it is possible to build and upload installable packages to the
[conda-forge](https://anaconda.org/conda-forge) [anaconda.org](https://anaconda.org/)
channel for Linux, Windows and OSX respectively.

To manage the continuous integration and simplify feedstock maintenance,
[conda-smithy](https://github.com/conda-forge/conda-smithy) has been developed.
Using the ``conda-forge.yml`` within this repository, it is possible to re-render all of
this feedstock's supporting files (e.g. the CI configuration files) with ``conda smithy rerender``.

For more information, please check the [conda-forge documentation](https://conda-forge.org/docs/).

Terminology
===========

**feedstock** - the conda recipe (raw material), supporting scripts and CI configuration.

**conda-smithy** - the tool which helps orchestrate the feedstock.
                   Its primary use is in the construction of the CI ``.yml`` files
                   and simplify the management of *many* feedstocks.

**conda-forge** - the place where the feedstock and smithy live and work to
                  produce the finished article (built conda distributions)


Updating openimageio-feedstock
==============================

If you would like to improve the openimageio recipe or build a new
package version, please fork this repository and submit a PR. Upon submission,
your changes will be run on the appropriate platforms to give the reviewer an
opportunity to confirm that the changes result in a successful build. Once
merged, the recipe will be re-built and uploaded automatically to the
`conda-forge` channel, whereupon the built conda packages will be available for
everybody to install and use from the `conda-forge` channel.
Note that all branches in the conda-forge/openimageio-feedstock are
immediately built and any created packages are uploaded, so PRs should be based
on branches in forks, and branches in the main repository should only be used to
build distinct package versions.

In order to produce a uniquely identifiable distribution:
 * If the version of a package **is not** being increased, please add or increase
   the [``build/number``](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#build-number-and-string).
 * If the version of a package **is** being increased, please remember to return
   the [``build/number``](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#build-number-and-string)
   back to 0.

Feedstock Maintainers
=====================

* [@JohanMabille](https://github.com/JohanMabille/)
* [@SylvainCorlay](https://github.com/SylvainCorlay/)
* [@h-vetinari](https://github.com/h-vetinari/)
* [@lgritz](https://github.com/lgritz/)
* [@wolfv](https://github.com/wolfv/)

