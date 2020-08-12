#!/bin/bash
##proc/parallel: controls parallelism
##@copyright GPL-2.0+

if bool $NOPARALLEL; then
	abwarn "Parallel build DISABLED, get a cup of coffee, now!"
	export MAKEFLAGS+=" -j1 "
else
	abinfo "Parallel build ENABLED"
	export MAKEFLAGS+=" -j$ABTHREADS "
fi
