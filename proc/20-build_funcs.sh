#!/bin/bash
##proc/build_funcs: Loads the build/ functions
##@copyright GPL-2.0+
ABBUILDS=()
for i in "$AB/build/*.sh"
do
	. $i
done
