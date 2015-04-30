abreqexe python

build_python_probe(){
	[ -f setup.py ]
}

build_python2(){
	python2 setup.py install --prefix=/usr --root=$PKGDIR --optimize=1
}

build_python2_clean(){
	python2 setup.py clean
}

build_python3(){
	python3 setup.py install --prefix=/usr --root=$PKGDIR --optimize=1
}

build_python_build(){
	if bool $NOPYTHON2
	then
		build_python3
	elif bool $NOPYTHON3
	then
		build_python2
	else
		build_python2
		build_python2_clean
		build_python3
	fi
}

export ABBUILDS="$ABBUILDS python"
