bool ABINSTALL && for i in $ABMPM $ABAPMS
do
	. $AB/$i/install
done

dpkg -i $TARGET_DIR/$PKGNAME.deb
rpm -ivh --force /root/rpmbuild/RPMS/x86_64/$PKGNAME-*.rpm
