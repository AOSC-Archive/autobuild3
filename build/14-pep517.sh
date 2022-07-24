#!/bin/bash
##15-python.sh: Builds Python PEP517 stuff
##@copyright GPL-2.0+

# PEP517 is only supported in Python 3
abtryexe python3 || pip3 || ((!ABSTRICT)) || ablibret

build_pep517_probe(){
	[ -f "$SRCDIR"/pyproject.toml ]
}

build_pep517_build(){
	BUILD_START
	if bool NOPYTHON3; then
		abdie "PEP517 is only supported in Python 3. Specifying NOPYTHON3 is contradictory!"
	fi
	if ! bool NOPYTHON2; then
		abwarn "PEP517 is only supported in Python 3. Please specify NOPYTHON2=1 to suppress this warning."
	fi
	BUILD_READY
	abinfo "Building Python (PEP517) package ..."
	python3 \
		-m build \
		--no-isolation \
		--wheel \
		|| abdie "Failed to build Python (PEP517) package: $?."

	abinfo "Installing Python (PEP517) package ..."
	python3 \
		-m installer \
		--destdir="$PKGDIR" \
		"$SRCDIR"/dist/*.whl
	BUILD_FINAL
}
ABBUILDS+=' pep517'
