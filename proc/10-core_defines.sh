#!/bin/bash
##defines: First we need the defines
##@copyright GPL-2.0+
# TODO: we may have to split this file. PKG/SRCDIR defs should be in ab3.sh.
export SRCDIR="$PWD"
export BLDDIR="$SRCDIR/abbuild"
export PKGDIR="$SRCDIR/abdist"
export SYMDIR="$SRCDIR/abdist-dbg"

BUILD_START(){ true; }
BUILD_READY(){ true; }
BUILD_FINAL(){ true; }

# Autobuild settings
. "$AB"/etc/autobuild/ab3_defcfg.sh

abrequire arch
. "$AB/arch/_common.sh"
BUILD=${ARCH_TARGET["$ABBUILD"]}
HOST=${ARCH_TARGET["$ABHOST"]}
# Allow overrides of some special variables, e.g. BUILD, *_DEF, etc.
. "$AB/arch/${ABHOST//\//_}.sh"

# To handle optenv*, which are noarch, but requires a special ABHOST.
DPKG_ARCH=${DPKG_ARCH:-$ABHOST}

if ! bool $ABSTAGE2; then
	_arch_trymore=1 arch_loadfiles defines || \
		abdie "Failed to source defines file: $?."
else
	abwarn "ABSTAGE2 returned true, loading stage2 defines ..."
	if arch_findfile defines.stage2; then
		_arch_trymore=1 arch_loadfiles defines.stage2 || \
                        abdie "Failed to source stage2 defines file: $?."
	else
		abwarn "Unable to find stage2 defines, falling back to normal defines ..."
		_arch_trymore=1 arch_loadfiles defines || \
			abdie "Failed to source defines file: $?."
	fi
fi
[[ ${ABHOST%%\/*} != $FAIL_ARCH ]] ||
	abdie "This package cannot be built for $FAIL_ARCH, e.g. $ABHOST."

if ! bool $ABSTRIP && bool $ABSPLITDBG; then
	abwarn "QA: ELF stripping is turned OFF."
	abwarn "    Won't package debug symbols as they are shipped in ELF themselves."
	ABSPLITDBG=0
fi

if [[ $ABHOST == noarch ]]; then
	abinfo "Architecture-agnostic (noarch) package detected, disabling -dbg package split ..."
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
