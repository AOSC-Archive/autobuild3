#!/bin/bash
##15-perl.sh: Builds Makefile.PL stuff
##@copyright GPL-2.0+
abtryexe perl || ablibret

build_perl_probe(){
	[ -f Makefile.PL ] || [ -h Makefile.PL ]
}

build_perl_build(){
	BUILD_START
	abinfo "Generating Makefile from Makefile.PL ..."
	PERL_MM_USE_DEFAULT=1 perl -I"$SRCDIR" Makefile.PL INSTALLDIRS=vendor || abdie "Makefile generation failed"
	BUILD_READY
	abinfo "Building Perl package ..."
	make V=1 VERBOSE=1 $MAKE_AFTER || abdie "Make failed"
	BUILD_FINAL
	abinfo "Installing Perl package ..."
	make V=1 VERBOSE=1 DESTDIR="$PKGDIR" install || abdie "Install failed"
}
ABBUILDS+=' perl'
