#!/bin/bash
##proc/cleanup: We always want our butt free of old build output
##@license GPL-2.0+
# Clean up!

# TODO: Different build type specific clean up.

if bool $ABCLEAN; then
	abinfo "Pre-build clean up..."
	rm -rf "$SRCDIR"/ab{dist,-dpkg,spec,scripts}
else
	abinfo "Moving away ab stuffs.."
	t="$(date -u +%s)_$RANDOM"
	mkdir -p "$SRCDIR"/_ab_backs/$t"
	mv "$SRCDIR"/ab{dist,-dpkg,spec,scripts} "$SRCDIR"/_ab_backs/$t"
	unset t
fi
