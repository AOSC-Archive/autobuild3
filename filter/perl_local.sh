#!/bin/bash
##filter/perl_local: Removes perllocal.pod.
##@copyright GPL-2.0+
filter_perllocal(){
	abinfo "Removed perllocal.pod."
	find "$PKGDIR" -name perllocal.pod -delete
	abinfo "Removed .packlist."
	find "$PKGDIR" -name .packlist -delete
}

export ABFILTERS="$ABFILTERS perl"
