#!/bin/bash
##proc/pack: packs the package.
##@copyright GPL-2.0+
for i in $ABMPM $ABAPMS; do
	abinfo "Building $i package(s) ..."
	. "$AB"/pm/"$i"/pack || aberr $i packing returned $?.
done
