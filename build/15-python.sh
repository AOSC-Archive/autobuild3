abreqexe python

build_python_probe(){
	[ -f setup.py ]	
}
build_python_build(){
        python2 setup.py install --prefix=/usr --root=`pwd`/abdist 
        bool $NOPYTHON3 || return 0
        python2 setup.py clean
        python3 setup.py install --prefix=/usr --root=`pwd`/abdist
}
export ABBUILDS="$ABBUILDS python"
