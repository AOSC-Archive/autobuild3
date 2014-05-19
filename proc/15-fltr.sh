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
for i in $ABFLTRS
do
	fltr_$i
done
popd > /dev/null
