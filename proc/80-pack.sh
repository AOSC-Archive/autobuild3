for i in $ABMPM $ABAPMS; do
	. $AB/$i/pack
done
tar cvfJ "${PKGNAME}_${PKGVER}.tar.xz" autobuild/
if [ $ABARCHIVE ]; then abinfo "Using $ABARCHIVE as autobuild archiver."; $ABARCHIVE "$PKGNAME" "$PKGVER"; else abinfo "Not using an archiver."; fi
