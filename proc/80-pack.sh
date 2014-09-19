repo_layout(){ for _layout in $(cat sets/repodirs); do [[ $PKGNAME =~ ^$_layout ]] && break; done; }
for i in $ABMPM $ABAPMS; do
	. $AB/$i/pack
	if [ "$ABARCHIVE" != "" ]
	then
		$ABARCHIVE $ABPACKAGE
	fi
done
abc="${PKGNAME}_${PKGVER}.tar.xz"
tar cvfJ $abc autobuild/

repo_layout # Implementation using bash regex, runs `break' when match and so keeps $_layout
mkdir -p $TARGET_DIR/os3-{ab,dpkg,rpm}/$_layout
cp -v *.tar.xz $TARGET_DIR/os3-ab/$_layout
cp -v *.deb $TARGET_DIR/os3-dpkg/$_layout
cp -v ~/root/rpmbuild/RPMS/x86_64/*.rpm $TARGET_DIR/os3-rpm/$_layout

[ "$ABARCHIVE" != "" ] && $ABARCHIVE $abc

