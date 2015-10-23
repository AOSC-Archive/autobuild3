autobuild3
==========
[![Stories in Ready](https://badge.waffle.io/AOSC-Dev/autobuild3.png?label=ready&title=Ready)](https://waffle.io/AOSC-Dev/autobuild3)

The new generation of [Autobuild](https://github.com/AOSC-Dev/autobuild) for AOSC OS3,
with deb/[rpm](https://github.com/AOSC-Dev/abdeb2rpm) support, and a QA system.

autobuild3 abstracts everything our distro need from the package managers.

Installing autobuild3
---------------------

Self-bootstrapping: `sudo ./ab3.sh`

HELP: `./ab3.sh help`

Porting
-------

autobuild3 contains some AOSC-specific code, especially some definitions about
the system. You may want to change it before you use it on your system.

License
-------

GNU GPLv2+. We are too lazy to add a header to all the source files, given that
lots of the files are even shorter than standard GPL header.
