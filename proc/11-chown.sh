#!/bin/bash
##proc/chown: change all file ownership in "$SRCDIR" to 0:0.
##@copyright GPL-2.0+

if (( EUID == 0 )); then
	chown -R 0:0 "$SRCDIR"
fi

