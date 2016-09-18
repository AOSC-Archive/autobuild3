#!/bin/bash
##filter/perl_local: Removes perllocal.pod.
##@copyright GPL-2.0+
filter_perl(){
	abinfo "Removed perllocal.pod."
	find "$PKGDIR" -name perllocal.pod -delete
	abinfo "Removed .packlist."
	find "$PKGDIR" -name .packlist -delete
}

export ABFILTERS="$ABFILTERS perl"
