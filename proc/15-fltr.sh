for i in $AB/fltr/*.sh
do
. $i
done
if [ ! -d abdist ]
then
	echo "Build failed: no abdist."
	exit 1
fi
pushd abdist > /dev/null
for ii in $ABFLTRS
do
	fltr_$ii
	echo "After $ii, PKGDEP=$PKGDEP"
done
popd > /dev/null
