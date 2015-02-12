export SRCDIR="$PWD"
export PKGDIR="$PWD/abdist"

[ -e autobuild/defines ] && { . autobuild/defines || abwarn "autobuild/defines returned a non-zero value." 
} || aberr "autobuild/defines not found."

# Autobuild settings
recsr $AB/etc/defaults/*

alias make='make $ABMK' # aliases aren't global, take care

# PKGREL Parameter, pkg and rpm friendly
# Test used for those who wants to override.
! [ $PKGREL ] && { PKGVER=$(echo $PKGVER| rev | cut -d - -f 2- | rev)
PKGREL=$(echo $PKGVER | rev | cut -d - -f 1 | rev)
if ([ "$PKGREL" == "$PKGVER" ] || ! [ $PKGREL ]); then PKGREL=0; fi; }

if [ -d $AB/spec ]; then
	recsr $AB/spec/*.sh
fi

for i in `cat $AB/params/*`; do
	export $i
done

export PYTHON=/usr/bin/python2
