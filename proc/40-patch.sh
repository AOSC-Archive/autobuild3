#!/bin/bash
##proc/patch: Loads the build/ functions
##@copyright GPL-2.0+
abrequire arch

if [ ! -f .patch ]
then
	if arch_loadfile_strict patch
	then
		touch .patch
	elif [ -f autobuild/patches/series ]
	then
		ab_apply_patches $(grep -v '^#' autobuild/patches/series)
		touch .patch
	elif [ -d autobuild/patches ]
	then
		ab_apply_patches autobuild/patches/*.{patch,diff} autobuild/patches/*.{patch,diff}."${CROSS:-$ARCH}"
		ab_reverse_patches autobuild/patches/r*.{patch,diff} autobuild/patches/*.r{patch,diff}."${CROSS:-$ARCH}"
		touch "$SRCDIR"/.patch
	fi
fi
