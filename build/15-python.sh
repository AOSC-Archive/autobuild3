#!/bin/bash
##15-python.sh: Builds Python stuffs
##@copyright GPL-2.0+
abtryexe python || ablibret
abtryexe python2 python3 || ((!ABSTRICT)) || ablibret

build_python_probe(){
	[ -f setup.py ]
}

build_python_build(){
	BUILD_START
	for PYTHON in "$(bool $NOPYTHON2 || which python2 || which python || echo)" \
	"$(bool $NOPYTHON3 || which python3 || echo)"; do
		[ "$PYTHON" ] || continue
		if bool $USE_PYTHON_BUILD_FIRST; then
			BUILD_READY
			"$PYTHON" build
		fi
		BUILD_FINAL
		"$PYTHON" setup.py install $MAKE_AFTER --prefix=/usr --root="$PKGDIR" --optimize=1 || return $?
		bool $NOPYTHONCLEAN || "$PYTHON" setup.py clean || true
	done
}
ABBUILDS+=' python'
