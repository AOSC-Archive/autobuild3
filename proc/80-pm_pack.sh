#!/bin/bash
##proc/pack: packs the package.
##@copyright GPL-2.0+
for i in $ABMPM $ABAPMS; do
	. "$AB"/pm/"$i"/pack || aberr $i packing returned $?.
done

if [ "$ABARCHIVE" ]; then
	abinfo "Using $ABARCHIVE as autobuild archiver."
	$ABARCHIVE "$PKGNAME" "$PKGVER" "$PKGREL" "$ABHOST"
else
	abinfo "Not using an archiver."
fi
