#!/bin/bash
##15-perl.sh: Builds Makefile.PL stuffs
##@copyright GPL-2.0+
abtryexe perl || ablibret

build_perl_probe(){
	[ -f Makefile.PL ] || [ -h Makefile.PL ]
}

build_perl_build(){
	BUILD_START
	PERL_MM_USE_DEFAULT=1 perl -I. Makefile.PL INSTALLDIRS=vendor
	BUILD_READY
	make $MAKE_AFTER
	BUILD_FINAL
	make DESTDIR="$PKGDIR" install
}
ABBUILDS+=' perl'
