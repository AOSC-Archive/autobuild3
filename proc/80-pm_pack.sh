#!/bin/bash
##proc/pack: packs the package.
##@copyright GPL-2.0+
touch "$SRCDIR/autobuild/conffiles"
for i in $ABMPM $ABAPMS; do
	. "$AB"/pm/"$i"/pack || aberr $i packing returned $?.
done

tar cvfJ "${PKGNAME}_${PKGVER}-${PKGREL}.tar.xz" autobuild/

if [ "$ABARCHIVE" ]; then
	abinfo "Using $ABARCHIVE as autobuild archiver."
	$ABARCHIVE "$PKGNAME" "$PKGVER" "$PKGREL"
else
	abinfo "Not using an archiver."
fi
