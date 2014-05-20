mkdir -p abscripts
echo "#! /bin/bash" > abscripts/postinst
echo "#! /bin/bash" > abscripts/prerm
cat autobuild/postinst > abscripts/postinst
cat autobuild/prerm > abscripts/prerm
chmod 755 abscripts/{postinst,prerm}
if [ -e autobuild/trigger ]
then
	echo "#! /bin/bash" > abscripts/trigger
	echo "#! /bin/bash" > abscripts/triggered
	echo "export PKGNAME=$PKGNAME" >> abscripts/trigger
	cat $AB/trigger/lib.sh >> abscripts/triggered
	cat autobuild/trigger >> abscripts/trigger
	cat autobuild/posrtinst >> abscripts/triggered
	chmod 755 abscripts/trigger{,ed}
	mkdir -p abdist/var/ab/trigger{s,ed}
	cp abscript/trigger abdist/var/ab/triggers/$PKGNAME
	cp abscript/triggered abdist/var/ab/triggered/$PKGNAME
fi
for i in $AB/scriptlet/*.sh
do
	. $i
done
for i in /var/ab/triggers/*
do
	$i
done


