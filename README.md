autobuild3
==========
[![Stories in Ready](https://badge.waffle.io/AOSC-Dev/autobuild3.png?label=ready&title=Ready)](https://waffle.io/AOSC-Dev/autobuild3)

Autobuild is a distribution packaging toolkit meant to carry out the following functions:

- Definition, therefore identification of source code
- Preparing and patching of source code
- Building of source code
- Quality control of built binaries
- Packaging of built binaries

Autobuild3 is essentially a set of scripts (`autobuild` is the only command script useful for invoking a build process) that works to automatically carry out the function listed above, and to simplify build configuration (build scripts in another word) using various pre-designed build routines, named `ABTYPE` or Autobuild Build Types. More will be discussed below (extensively).

Autobuild3 is a successor to the original [Autobuild](https://github.com/AOSC-Dev/autobuild) used back in 2013 when AOSC OS2 was initially rebooted as a independent Linux distribution. Unlike Autobuild being a distribution specific and single backend toolkit, Autobuild3 is distribution neutral and supports various backends:

- DPKG, the most "native" backend of all, using `dpkg-deb` and Autobuild variables to control the generation of DPKG control files, and henceforth building the packages.
  - The "native" part is largely caused by some autobuild2 heritage in our brains and in the build scripts, which ended up infecting many other parts of ab3. For example, the architecture names in `ABHOST` and `ABBUILD` are dpkg names, the PM dep model is based on dpkg representations, ...
- PKGBUILD (coming soon), using Autobuild variables to generate `PKGBUILD` files, using a temporary install root, to provide `makepkg` with a fake binary packaging process.

Installing autobuild3
---------------------

- Self-bootstrapping: `sudo ./ab3.sh`
- HELP: `./ab3.sh help`

Documentations
--------------

Documentations can be found [here](https://github.com/AOSC-Dev/aosc-os-abbs/wiki/Autobuild3).

Porting
-------

Autobuild3 contains some AOSC-specific code, especially some definitions about system paths. You may want to change it before you use it on your system.

License
-------

GNU GPLv2+.
