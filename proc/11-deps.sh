abrequire pm

pm_checkdep $BUILDDEP $PKGDEP || (
	abinfo "Build or runtime dependencies not satisfied, now fetching needed packages."
	pm_repoupdate
	pm_repoinstall $BUILDDEP $PKGDEP
)
