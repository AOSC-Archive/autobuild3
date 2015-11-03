#!/bin/bash
##defines: First we need the defines
##@copyright GPL-2.0+
# TODO: we may have to split this file. PKG/SRCDIR defs should be in ab3.sh.
export SRCDIR="$PWD"
export PKGDIR="$PWD/abdist"

# Autobuild settings
. "$AB"/etc/autobuild/ab3_defcfg.sh

abrequire arch
. "$AB/arch/_common.sh"
. "$AB/arch/${CROSS:-$ARCH}.sh"

_arch_trymore=1 arch_loadfiles defines || abdie "defines returned a non-zero value: $?." 

if bool "$32SUBSYSBUILD" || [[ "$PKGNAME" == *+32 && ARCH == amd64 ]]
then
	abinfo "Detected 32subsys build."
	CROSS=i386
fi

arch_initcross
# PKGREL Parameter, pkg and rpm friendly
# Test used for those who wants to override.
# TODO foreport verlint
# TODO verlint backwriting when ((!PROGDEFINE)).
# TODO automate $PKG* namespace and remove abbs `spec`
if [ ! "$PKGREL" ]; then
	PKGVER=$(echo $PKGVER| rev | cut -d - -f 2- | rev)
	PKGREL=$(echo $PKGVER | rev | cut -d - -f 1 | rev)
	if [ "$PKGREL" == "$PKGVER" ] || [ ! "$PKGREL" ]; then PKGREL=0; fi;
fi

# Programmable modules should be put here.
arch_loadfile functions

export `cat $AB/exportvars/*`

export PYTHON=/usr/bin/python2
