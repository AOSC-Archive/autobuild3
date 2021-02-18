#!/bin/bash
##30-dummy.sh: Builds dummy/meta/transitional packages
##@copyright GPL-2.0+

build_dummy_probe(){
	true
}

build_dummy_build(){
	abinfo "Creating a dummy package ..."
	mkdir -pv "$PKGDIR" \
		|| abdie "Failed to create a dummy package: $?."
}

ABBUILDS+=' dummy'
