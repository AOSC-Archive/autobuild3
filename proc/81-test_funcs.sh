#!/bin/bash
##proc/build_funcs: Loads the tests/ functions
##@copyright GPL-2.0+
for i in "$AB/tests"/*.sh
do
	. "$i"
done
