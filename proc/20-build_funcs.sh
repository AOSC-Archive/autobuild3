#!/bin/bash
##proc/build_funcs: Loads the build/ functions
##@copyright GPL-2.0+
for i in "$AB/build"/*.sh
do
	. "$i"
done
