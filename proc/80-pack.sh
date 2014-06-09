for i in $ABMPM $ABAPMS
do
	. $AB/$i/pack
	if [ "$ABARCHIVE" != "" ]
	then
		$ABARCHIVE $ABPACKAGE
	fi
done
abc="${PKGNAME}_${PKGVER}.tar.xz"
tar cvfJ $abc autobuild/
[ "$ABARCHIVE" != "" ] && $ABARCHIVE $abc
