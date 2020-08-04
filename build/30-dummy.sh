#!/bin/bash
##30-dummy.sh: Builds dummy/meta/transitional packages
##@copyright GPL-2.0+
abtryexe node npm || ((!ABSTRICT)) || ablibret

build_npm_build(){
	abinfo "Building dummy package ..."
	mkdir -pv "$PKGDIR"
}

ABBUILDS+=' dummy'
