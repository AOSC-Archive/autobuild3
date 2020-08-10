#!/bin/bash
##15-python.sh: Builds Python stuff
##@copyright GPL-2.0+
abtryexe python || ablibret
abtryexe python2 python3 || ((!ABSTRICT)) || ablibret

build_python_probe(){
	[ -f setup.py ]
}

build_python_build(){
	BUILD_START
	for PYTHON in "$(bool $NOPYTHON2 || command -v python2 || command -v python || echo)" \
	"$(bool $NOPYTHON3 || command -v python3 || echo)"; do
		[ "$PYTHON" ] || continue
		if bool $USE_PYTHON_BUILD_FIRST; then
			BUILD_READY
			abinfo "Building Python (PyPI) package using $PYTHON ..."
			"$PYTHON" build
		fi
		BUILD_FINAL
		abinfo "Installing Python (PyPI) package using $PYTHON ..."
		"$PYTHON" setup.py install $MAKE_AFTER --prefix=/usr --root="$PKGDIR" --optimize=1 || return $?
		abinfo "Cleaning Python (PyPI) package source tree ..."
		bool $NOPYTHONCLEAN || "$PYTHON" setup.py clean || true
	done
}
ABBUILDS+=' python'
