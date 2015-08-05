mkdir -p abscripts

for i in postinst prerm postrm preinst; do
	echo "#!/bin/bash" > abscripts/$i
	cat autobuild/$i >> abscripts/$i 2>/dev/null || abinfo "Creating empty $i."
	chmod 755 abscripts/$i
done

if [ -e autobuild/triggers ]; then
	[ $AB_DBG ] && abinfo "Triggers found."
	echo "#!/bin/bash" > abscripts/trigger
	echo "#!/bin/bash" > abscripts/triggered
	echo "export PKGNAME=$PKGNAME" >> abscripts/trigger
	cat $AB/trigger/lib.sh >> abscripts/trigger
	cat autobuild/triggers >> abscripts/trigger
	cat autobuild/postinst >> abscripts/triggered
	chmod 755 abscripts/trigger{,ed}
	mkdir -p abdist/var/ab/trigger{s,ed}
	cp abscripts/trigger abdist/var/ab/triggers/$PKGNAME
	cp abscripts/triggered abdist/var/ab/triggered/$PKGNAME
fi

recsr $AB/scriptlet/*.sh

for i in /var/ab/triggers/*; do
	[ "$(basename "${i##.sh}")" == "$PKGNAME" ] || $i || abwarn "trigger $i: $?"
done
