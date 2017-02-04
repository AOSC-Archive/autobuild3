#!/bin/bash
##20-npm.sh: Builds NPM registry archives
##@copyright GPL-2.0+
abtryexe node npm || ((!ABSTRICT)) || ablibret

#FIXME: NPM archives requires using a non-extracted tarball.
build_npm_probe(){
	[ -e $PKGNAME-$PKGVER.tgz ]
}

build_npm_build(){
	npm install -g --user root \
                    --prefix "$PKGDIR"/usr "$SRCDIR"/$PKGNAME-$PKGVER.tgz
}

ABBUILDS+=' npm'
