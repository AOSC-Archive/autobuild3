#!/bin/bash
##proc/conffiles.sh: Generate conffiles if not already written
##@copyright GPL-2.0+
if [[ ! -e "$SRCDIR"/autobuild/conffiles && -d "$PKGDIR"/etc ]]; then
	abwarn 'Detected /etc in $PKGDIR, but autobuild/conffiles is not found - attempting generation ...'
	find "$PKGDIR"/etc -type f -printf '/etc/%P\n' \
		2>&1 | tee  "$SRCDIR"/autobuild/conffiles
fi
