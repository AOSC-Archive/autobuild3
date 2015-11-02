#!/bin/bash
##proc/build_probe: Guess the build type
##@copyright GPL-2.0+
if [ -z "$ABTYPE" ]; then
	for i in $ABBUILDS; do
		# build are all plugins now.
		if build_${i}_probe; then
			export ABTYPE=$i
			break 
		fi
	done
fi

if [ -z "$ABTYPE" ]; then
	abdie "Cannot determine build type."
fi
