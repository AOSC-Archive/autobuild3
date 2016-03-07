#!/bin/bash
##filter/perl_local: Removes perllocal.pod.
##@copyright GPL-2.0+
filter_perllocal(){
	abinfo "Removed perllocal.pod."
	rm -f "$PKGDIR"/usr/lib/perl5/**/perllocal.pod
}

export ABFILTERS="$ABFILTERS perllocal"
