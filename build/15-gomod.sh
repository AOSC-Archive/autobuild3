#!/bin/bash
##15-gomod.sh: Builds Go projects using Go Modules and Go 1.11+
##@copyright GPL-2.0+
abtryexe go || ablibret

build_gomod_probe(){
	[ -f "$SRCDIR"/go.mod ] \
		&& [ -f "$SRCDIR"/go.sum ] # go.sum is required for security reasons
}

build_gomod_build(){
	BUILD_START
	export GO111MODULE=on
	abinfo 'Note, this build type only works with Go 1.11+ modules'
	[ -f Makefile ] && abwarn "This project might be using other build tools than Go itself."
	if ! bool "$ABSHADOW"; then
		abdie "ABSHADOW must be set to true for this build type: $?."
	fi

	mkdir "$BLDDIR" \
		|| abdie "Failed to create $SRCDIR/abbuild: $?."
	cd "$BLDDIR" \
		|| abdie "Failed to cd $SRCDIR/abbuild: $?."

	abinfo "Fetching Go modules dependencies ..."
	GOPATH="$SRCDIR/abgopath" go get .. \
		|| abdie "Failed to fetch Go module dependencies: $?."
	BUILD_READY
	mkdir -pv "$PKGDIR/usr/bin/"
	abinfo "Compiling Go module ..."
	GOPATH="$SRCDIR/abgopath" \
		go build ${GO_BUILD_AFTER} .. \
		|| abdie "Failed to build Go module: $?."
	abinfo "Copying executable file(s) ..."
	find "$SRCDIR" -type f -executable \
		-exec cp -av '{}' "$PKGDIR/usr/bin/" ';' \
		|| abdie "Failed to copy executable file(s): $?."
	BUILD_FINAL
	cd "$SRCDIR" \
		|| abdie "Failed to return to source directory: $?."
}

ABBUILDS+=' gomod'
