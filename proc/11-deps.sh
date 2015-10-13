#!/bin/bash
##proc/deps: We want to install the dependencies
##@license GPL-2.0+
abrequire pm

# FIXME: The flat stuff gets stupid with 'foo | bar' packs. Guess why.
FLATDEP="$(pm_deflat $PKGDEP $BUILDDEP)"
if ! pm_exists $FLATDEP; then
	abinfo "Build or runtime dependencies not satisfied, now fetching needed packages."
	pm_repoupdate
	pm_repoinstall $FLATDEP
fi
unset FLATDEP
