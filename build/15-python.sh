abreqexe python
abtryexe python2 python3

build_python_probe(){
	[ -f setup.py ]
}

build_python_build(){
	for PYTHON in "$(bool NOPYTHON2 || which python2 || which python || echo :)" \
	"$(bool NOPYTHON3 || which python3 || echo :)"; do
		"$PYTHON" setup.py install $MAKE_AFTER --prefix=/usr --root="$PKGDIR" --optimize=1 || return $?
		bool $NOPYTHONCLEAN || "$PYTHON" setup.py clean || true
	fi
}

export ABBUILDS="$ABBUILDS python"
