#!/bin/bash
##proc/deps: We want to install the dependencies
##@copyright GPL-2.0+
abrequire pm

# FIXME: The flat stuff gets stupid with 'foo | bar' packs. Guess why.
if [[ $BULDDEPONLY == 1 ]]; then
	FLATDEP="$(pm_deflat $BUILDDEP)"
else
	FLATDEP="$(pm_deflat $PKGDEP $BUILDDEP $PKGPRDEP)"
fi

if ! pm_exists $FLATDEP; then
	abinfo "Build or runtime dependencies not satisfied, now fetching needed packages."
	pm_repoupdate
	pm_repoinstall $FLATDEP || abdie "Cannot install needed dependencies."
fi
unset FLATDEP
