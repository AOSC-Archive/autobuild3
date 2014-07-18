export SRCDIR="$PWD"
export PKGDIR="$PWD/abdist"

# Autobuild settings
recsr $AB/etc/defaults/*

. autobuild/defines || return 1

alias make='make $ABMK' # aliases aren't global, take care

# PKGREL Parameter, pkg and rpm friendly
# Test used for those who wants to override.
! [ $PKGREL ] && (PKGVER=$(echo $PKGVER| rev | cut -d - -f 2- | rev)
PKGREL=$(echo $PKGVER | rev | cut -d - -f 1 | rev)
PKGREL=${PKGREL:-0})

if [ -d $AB/spec ]; then
	recsr $AB/spec/*.sh
fi

for i in `cat $AB/params/*`; do
	export $i
done

export PYTHON=/usr/bin/python2