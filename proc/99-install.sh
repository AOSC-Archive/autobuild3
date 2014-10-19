if bool $ABINSTALL
then for i in $ABMPM $ABAPMS
do
	. $AB/$i/install
done
else dpkg -i $PKGNAME.deb || aberr "DPKG installation failed."
rpm -Uvh --force /root/rpmbuild/RPMS/x86_64/$PKGNAME-$PKGVER-$PKGREL*.rpm || aberr "RPM installation failed."
fi
