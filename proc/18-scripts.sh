mkdir -p abscripts
echo "#! /bin/bash" > abscripts/postinst
echo "#! /bin/bash" > abscripts/prerm
cat autobuild/postinst > abscripts/postinst
cat autobuild/prerm > abscripts/prerm
chmod 755 abscripts/{postinst,prerm}
if [ -e autobuild/triggers ]
then
	echo "#! /bin/bash" > abscripts/trigger
	echo "#! /bin/bash" > abscripts/triggered
	echo "export PKGNAME=$PKGNAME" >> abscripts/trigger
	cat $AB/trigger/lib.sh >> abscripts/trigger
	cat autobuild/triggers >> abscripts/trigger
	cat autobuild/postinst >> abscripts/triggered
	chmod 755 abscripts/trigger{,ed}
	mkdir -p abdist/var/ab/trigger{s,ed}
	cp abscripts/trigger abdist/var/ab/triggers/$PKGNAME
	cp abscripts/triggered abdist/var/ab/triggered/$PKGNAME
fi
for i in $AB/scriptlet/*.sh
do
	. $i
done
for i in /var/ab/triggers/*
do
	[ "`basename $i`" != "$PKGNAME" ] && $i
done


