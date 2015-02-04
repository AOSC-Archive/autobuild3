if bool $ABINSTALL
then for i in $ABMPM $ABAPMS
do
	. $AB/$i/lib/install.sh
done
fi
