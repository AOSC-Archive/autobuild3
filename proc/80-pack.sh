for i in $ABMPM $ABAPMS; do
	. $AB/$i/pack
done
tar cvfJ "${PKGNAME}_${PKGVER}.tar.xz" autobuild/
[ $ABARCHIVE ] && $ABARCHIVE "$PKGNAME" "$PKGVER"
