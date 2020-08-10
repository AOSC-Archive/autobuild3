#!/bin/bash
##25-npm.sh: Builds NPM registry archives
##@copyright GPL-2.0+
abtryexe node npm || ((!ABSTRICT)) || ablibret

build_npm_probe(){
	[ -f package.json ]
}

build_npm_audit(){
	if [ -f yarn.lock ]; then
		yarn audit || abdie 'Vulnerabilities detected! Aborting...'
	elif [ -f packages-lock.json ]; then
		npm audit || abdie 'Vulnerabilities detected! Aborting...'
	else
		abdie 'The project does not contain any lock files. Unable to conduct the audit.'
	fi
}

build_npm_build(){
	build_npm_audit
	abinfo "Creating a symlink to make NPM happy ..."
	ln -sv "$SRCDIR/../$PKGNAME-$PKGVER."* "$PKGNAME-$PKGVER.tgz"
	abinfo "Installing NPM package ..."
	npm install --production -g --user root \
                    --prefix "$PKGDIR"/usr "$PKGNAME-$PKGVER.tgz" || abdie "Could not install from archives"
}

ABBUILDS+=' npm'
