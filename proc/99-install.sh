# ABINSTALL no longer will be fed with boolean.
# Put in PMs instead.

for i in $ABINSTALL
do
	. $AB/$i/install || aberr $i install returned $?.
done

