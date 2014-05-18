. autobuild/defines
for i in $AB/etc/defaults/*
do
. $i
done
. autobuild/defines
for i in `cat $AB/params/*`
do
export $i
done
