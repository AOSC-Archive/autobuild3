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
	PERL_MM_USE_DEFAULT=1 perl -I"$SRCDIR" Makefile.PL INSTALLDIRS=vendor
	BUILD_READY
	abinfo "Building Perl package ..."
	make $MAKE_AFTER
	BUILD_FINAL
	abinfo "Installing Perl package ..."
	make DESTDIR="$PKGDIR" install
}
ABBUILDS+=' perl'
