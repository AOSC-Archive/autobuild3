#!/bin/bash
##proc/patch: Loads the build/ functions
##@copyright GPL-2.0+
abrequire arch

if [ ! -f "$SRCDIR"/.patch ]; then
	if [ -f "$SRCDIR"/autobuild/patch ]; then
		arch_loadfile_strict patch
		touch "$SRCDIR"/.patch
	elif [ -f "$SRCDIR"/autobuild/patch ] && bool $ABSTAGE2; then
		if arch_loadfile_strict patch.stage2; then
			abwarn "ABSTAGE2 returned true, running stage2 patch script ..."
			arch_loadfile_strict patch.stage2
		elif arch_loadfile_strict patch; then
			abwarn "ABSTAGE2 returned true, running stage2 patch script ..."
			abwarn "Could not find self-defined stage patch script, failling back to main patch script ..."
			arch_loadfile_strict patch
		else
			true
		fi
		touch "$SRCDIR"/.patch
	elif [ -f "$SRCDIR"/autobuild/patches/series ]; then
		ab_apply_patches \
			$(grep -v '^$\|^#' autobuild/patches/series | sed "s@^@$SRCDIR/autobuild/patches/@")
		touch "$SRCDIR"/.patch
	elif [ -d "$SRCDIR"/autobuild/patches ]; then
		ab_apply_patches \
			"$SRCDIR"/autobuild/patches/*.{patch,diff} \
			"$SRCDIR"/autobuild/patches/*.{patch,diff}."${CROSS:-$ARCH}"
		ab_reverse_patches \
			"$SRCDIR"/autobuild/patches/*.r{patch,diff} \
			"$SRCDIR"/autobuild/patches/*.r{patch,diff}."${CROSS:-$ARCH}"
		touch "$SRCDIR"/.patch
	fi
fi

cd "$SRCDIR"
