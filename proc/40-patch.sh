#!/bin/bash
##proc/patch: Loads the build/ functions
##@copyright GPL-2.0+
abrequire arch

PATCHFLAGS="-Np1 -t"

if [ ! -f .patch ]
then
	if arch_loadfile patch
	then
		touch .patch
	elif [ -f autobuild/patches/series ]
	then
		for i in $(grep -v '^#' autobuild/patches/series); do
			abinfo "Applying patch $i ..."
			patch $PATCHFLAGS -i autobuild/patches/$i || abdie "Applying patch $i failed"
		done
		touch .patch
	elif [ -d autobuild/patches ]
	then
		for i in autobuild/patches/*.{patch,diff}; do
			abinfo "Applying patch $i ..."
			patch $PATCHFLAGS -i "$i" || abdie "Applying patch $i failed"
		done
		for i in autobuild/patches/*.{patch,diff}."${CROSS:-$ARCH}"; do
			abinfo "Applying patch $i ..."
			patch $PATCHFLAGS -i "$i" || abdie "Applying patch $i failed"
		done
		touch .patch
	fi
fi
