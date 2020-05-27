#!/bin/bash
##20-npm.sh: Builds NPM registry archives
##@copyright GPL-2.0+
abtryexe node npm || ((!ABSTRICT)) || ablibret

build_npm_probe(){
	[ -f package.json ]
}

build_npm_build(){
	ln -sv "$SRCDIR/../$PKGNAME-$PKGVER."* "$PKGNAME-$PKGVER.tgz"
	npm install --production -g --user root \
                    --prefix "$PKGDIR"/usr "$PKGNAME-$PKGVER.tgz" || abdie "Could not install from archives"
}

ABBUILDS+=' npm'
