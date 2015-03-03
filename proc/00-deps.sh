abrequire pm
pm_checkdep $BUILDDEP $PKGDEP || (
pm_repoupdate
pm_repoinstall $BUILDDEP $PKGDEP
)
