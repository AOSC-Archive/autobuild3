abreqexe python

build_python_probe(){
	[ -f setup.py ] || return 1
	if bool $NOPYTHON2 && ! bool $NOPYTHON3; then
		PYTHON="$(which python2 || which python)"
	else
		PYTHON="$(which python3)"
	fi
}

build_python_build(){
	$PYTHON setup.py install $MAKE_AFTER --prefix=/usr --root=$PKGDIR --optimize=1 || return $?
	bool $NOPYTHONCLEAN && $PYTHON setup.py clean || true
}

export ABBUILDS="$ABBUILDS python"
