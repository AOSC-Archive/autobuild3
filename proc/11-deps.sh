abrequire pm

FLATDEP="$(pm_depflat $PKGDEP $BUILDDEP)"
if ! pm_exists $FLATDEP; then
	abinfo "Build or runtime dependencies not satisfied, now fetching needed packages."
	pm_repoupdate
	pm_repoinstall $FLATDEP
fi
unset $FLATDEP
