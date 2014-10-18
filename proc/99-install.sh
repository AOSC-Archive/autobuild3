bool ABINSTALL && for i in $ABMPM $ABAPMS
do
	. $AB/$i/install
done

dpkg -i $PKGNAME.deb || aberr "DPKG installation failed."
rpm -Uvh --force /root/rpmbuild/RPMS/x86_64/$PKGNAME-$PKGVER-$PKGREL*.rpm || aberr "RPM installation failed."
