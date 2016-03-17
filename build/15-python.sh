#!/bin/bash
##15-python.sh: Builds Python stuffs
##@copyright GPL-2.0+
abtryexe python || ablibret
abtryexe python2 python3 || ((!ABSTRICT)) || ablibret

build_python_probe(){
	[ -f setup.py ]
}

build_python_build(){
	local snakes=()
	if ! bool $NOPYTHON2; then
		{
			command -v python2 && snakes+=(python2);
		} || {
			command -v python  && snakes+=(python);
		}
	fi
	if ! bool $NOPYTHON3; then
		command -v python3 && snakes+=(python3)
	fi
	BUILD_START
	for PYTHON in "${snakes[@]}"; do
		[ "$PYTHON" ] || continue
		if bool $USE_PYTHON_BUILD_FIRST; then
			BUILD_READY
			"$PYTHON" build
		fi
		BUILD_FINAL
		"$PYTHON" setup.py install "${MAKE_AFTER[@]}" "--prefix=$PREFIX" --root="$PKGDIR" --optimize=1  | ablog || return $PIPESTATUS
		bool $NOPYTHONCLEAN || "$PYTHON" setup.py clean || true
	done
}
ABBUILDS+=('python')
