#!/bin/bash
##proc/scripts: Silly way to deal with scripts
##@copyright GPL-2.0+
mkdir -p abscripts

for i in postinst prerm postrm preinst; do
	abinfo "Generating and installing package management scripts ..."
	echo "#!/bin/bash" > abscripts/$i
	cat autobuild/$i >> abscripts/$i 2>/dev/null || abinfo "Creating empty $i."
	chmod 755 abscripts/$i
done

if [ -f "$SRCDIR"/autobuild/templates ]; then
	abinfo "Installing Debconf templates ..."
	cp -v "$SRCDIR"/autobuild/templates \
		abscripts/templates
fi

recsr "$AB/scriptlet"/*.sh
