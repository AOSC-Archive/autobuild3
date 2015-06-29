recsr $AB/filter/*.sh

[ -d $PKGDIR ] || abdie "abdist not found.\n in proc/60-filter.sh"

pushd $PKGDIR > /dev/null

for ii in $ABFILTERS; do
	filter_$ii
done

popd > /dev/null
