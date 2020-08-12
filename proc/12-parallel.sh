#!/bin/bash
##proc/parallel: make -j, distcc and ccache
##@copyright GPL-2.0+

if bool $NOPARALLEL; then
	abwarn "Parallel build DISABLED, get a cup of coffee, now!"
else
	abinfo "Parallel build ENABLED"
fi

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
	# we do acbs in random directories, so we must use file_macro to make them still work
	export CCACHE_SLOPPINESS=file_macro
	((ab_distcc)) && export CCACHE_PREFIX=distcc
	abinfo "We have the big ccache by our side!"
fi
# Final merge.
if ((ab_distcc)) && ! bool $NOPARALLEL; then
	export CC="distcc $CC" CXX="distcc $CXX" OBJC="distcc $OBJC" OBJCXX="distcc $OBJCXX"
elif ((ab_ccache)); then
	export CC="ccache $CC" CXX="ccache $CXX" OBJC="ccache $OBJC" OBJCXX="ccache $OBJCXX"
fi
# I don't think someone would be unlucky enough to use the same names. Not unset.
bool $NOPARALLEL || export MAKEFLAGS+=" -j$ABTHREADS "
