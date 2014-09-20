autobuild3
==========

The new generation of [Autobuild](https://github.com/AOSC-Dev/autobuild) for AOSC OS3,
with deb/[rpm](https://github.com/AOSC-Dev/abdeb2rpm) support, and a QA system.

autobuild3 abstracts everything our distro need from the package managers.

BUILDING
--------
Without autobuild:
`AB_SELF= bash ab3.sh; autobuild`
Will build autobuild twice, one without autobuild and another with installed autobuild.
