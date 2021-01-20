#!/bin/bash
##defines: First we need the defines
##@copyright GPL-2.0+
# TODO: we may have to split this file. PKG/SRCDIR defs should be in ab3.sh.
export SRCDIR="$PWD"
export PKGDIR="$PWD/abdist"
export SYMDIR="$PWD/abdist-dbg"

# Avoid dpkg-deb failure with larger packages on low RAM hosts.
export TMPDIR="$SRCDIR"

BUILD_START(){ true; }
BUILD_READY(){ true; }
BUILD_FINAL(){ true; }

# Autobuild settings
. "$AB"/etc/autobuild/ab3_defcfg.sh

abrequire arch
. "$AB/arch/_common.sh"
. "$AB/arch/${ABHOST//\//_}.sh" # Also load overlay configuration.
BUILD=${ARCH_TARGET["$ABBUILD"]}
HOST=${ARCH_TARGET["$ABHOST"]}

_arch_trymore=1 arch_loadfiles defines || abdie "defines returned a non-zero value: $?." 
[[ ${ABHOST%%\/*} != $FAIL_ARCH ]] ||
	abdie "This package cannot be built for $FAIL_ARCH, e.g. $ABHOST."

if ! bool $ABSTRIP && bool $ABSPLITDBG; then
	abwarn "QA: ELF stripping is turned OFF."
	abwarn "    Won't package debug symbols as they are shipped in ELF themselves."
	ABSPLITDBG=0
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
