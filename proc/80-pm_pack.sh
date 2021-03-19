#!/bin/bash
##proc/pack: packs the package.
##@copyright GPL-2.0+
for i in $ABMPM $ABAPMS; do
	. "$AB"/pm/"$i"/pack || aberr $i packing returned $?.
done
