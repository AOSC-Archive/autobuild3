recsr $AB/fltr/*.sh
[ -d $PKGDIR ] || abdie "abdist not found.\n in proc/60-fltr.sh"
pushd $PKGDIR > /dev/null
for ii in $ABFLTRS
do
	fltr_$ii
done
popd > /dev/null
