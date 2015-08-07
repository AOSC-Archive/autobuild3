# Still, let's use ABMK. MAKEFLAGS should be in defines.
: ${ABTHREADS=$(( $(nproc) * 2 + 1))}
if bool $NOPARALLEL; then
	abwarn "Parallel build DISABLED, get a cup of coffee, now!"
fi
abinfo "Parallel build ENABLED"
# Advanced building. Need some code cleaning.
if ! bool $NOPARALLEL && boolopt NO_DISTCC && _which distcc &>/dev/null; then
	ab_distcc=1
	if boolopt NO_DISTCCPUMP && _which pump &>/dev/null; then
		ab_distccpump=1
		MAKE_PREFIX="pump"
	fi
	abinfo "Going DISTCC!"
	ABTHREADS=${DISTCC_THREADS:-$((ABTHREADS*2))}
fi
if boolopt CCACHE && ((!ab_distccpump)) && _which ccache &>/dev/null; then
	ab_ccache=1
	((ab_distcc)) && export CCACHE_PREFIX=distcc
fi
# Final merge.
if ((ab_distcc)) && ! bool $NOPARALLEL; then
	export CC="distcc $CC" CXX="distcc $CXX"
elif ((ab_ccache)); then
	export CC="ccache $CC" CXX="ccache $CXX"
fi
# I don't think someone would be unlucky enough to use the same names. Not unset.
bool $NOPARALLEL || ABMK+=" -j$ABTHREADS "	
