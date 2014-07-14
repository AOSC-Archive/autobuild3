export SRCDIR="$PWD"
export PKGDIR="$PWD/abdist"

# Autobuild settings
. AB/etc/defaults/*

. autobuild/defines || return 1

if [ -d $AB/spec ]
then
	for i in $AB/spec/*.sh
	do
		. $i
	done
fi

for i in `cat $AB/params/*`
do
	export $i
done

export PYTHON=/usr/bin/python2