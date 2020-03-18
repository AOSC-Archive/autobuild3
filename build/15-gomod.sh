#!/bin/bash
##15-gomod.sh: Builds Go projects using Go Modules and Go 1.11+
##@copyright GPL-2.0+
abtryexe go || ablibret

build_gomod_probe(){
	[ -f go.mod ] && [ -f go.sum ]  # go.sum is required for security reasons
}

build_gomod_build(){
	BUILD_START
	export GO111MODULE=on
	abinfo 'Note, this build type only works with Go 1.11+ modules'
	[ -f Makefile ] && abwarn "This project might be using other build tools than Go itself."
	if ! bool $ABSHADOW then
		abdie 'ABSHADOW must be set to true for this build type!'
	fi

	rm -rf build
	mkdir build || abdie 'Failed to create $SRCDIR/build'
	cd build

	GOPATH="$SRCDIR/abgopath" go get
	BUILD_READY
	mkdir -p "$PKGDIR/usr/bin/"
	GOPATH="$SRCDIR/abgopath" go build . ${GO_BUILD_AFTER}
	cp -av * "$PKGDIR/usr/bin/"
	BUILD_FINAL
	cd ..
}

ABBUILDS+=' gomod'
