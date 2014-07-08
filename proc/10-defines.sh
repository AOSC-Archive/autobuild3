. autobuild/defines

for i in $AB/etc/defaults/*
# What? /etc/defaults/grub ?
do
	. $i
done

. autobuild/defines

if [ -d $AB/spec ]
then
	for i in $AB/spec/*.sh
	do
		$i
	done
fi

for i in `cat $AB/params/*`
do
	export $i
done

export PYTHON=/usr/bin/python2
