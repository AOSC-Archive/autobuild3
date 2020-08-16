#!/bin/bash
##proc/conffiles.sh: Generate conffiles if not already written
##@copyright GPL-2.0+

# Generate a cached conffiles.
find "$PKGDIR"/etc -type f -printf '/etc/%P\n' \
	| sort > "$SRCDIR"/conffiles.ab

if [[ -d "$PKGDIR"/etc && ! -e "$SRCDIR"/autobuild/conffiles ]]; then
	abwarn 'Detected /etc in $PKGDIR, but autobuild/conffiles is not found - attempting generation ...'
	abinfo 'Appending the following to autobuild/conffiles ...'
	cat "$SRCDIR"/conffiles.ab \
		2>&1 | sort | tee "$SRCDIR"/autobuild/conffiles
elif ! diff "$SRCDIR"/conffiles.ab <(sort "$SRCDIR"/autobuild/conffiles) \
	>/dev/null 2>&1; then
	abinfo 'Found autobuild/conffiles - good job! Content as follows ...'
        cat "$SRCDIR"/autobuild/conffiles | sort
	abwarn 'However, there seems to be more/less files found in $PKGDIR/etc ...'
	abwarn 'Please compare the following list of files against the current autobuild/conffiles ...'
	cat "$SRCDIR"/conffiles.ab
else
	abinfo 'Found autobuild/conffiles - all good!'
fi
