#!/bin/bash
##proc/patch: Loads the build/ functions
##@copyright GPL-2.0+
abrequire arch

if [ ! -f "$SRCDIR"/.patch ]
then
	if arch_loadfile_strict patch; then
		touch "$SRCDIR"/.patch
	elif [ -f "$SRCDIR"/autobuild/patches/series ]; then
		ab_apply_patches \
			"$SRCDIR"/autobuild/patches/$(grep -v '^#' autobuild/patches/series)
		touch "$SRCDIR"/.patch
	elif [ -d "$SRCDIR"/autobuild/patches ]; then
		ab_apply_patches \
			"$SRCDIR"/autobuild/patches/*.{patch,diff} \
			"$SRCDIR"/autobuild/patches/*.{patch,diff}."${CROSS:-$ARCH}"
		ab_reverse_patches \
			"$SRCDIR"/autobuild/patches/r*.{patch,diff} \
			"$SRCDIR"/autobuild/patches/*.r{patch,diff}."${CROSS:-$ARCH}"
		touch "$SRCDIR"/.patch
	fi
fi
