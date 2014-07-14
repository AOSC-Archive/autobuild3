abreqexe python

build_python_probe(){
        [ -f setup.py ]
}
build_python_build(){
        python2 setup.py install --prefix=/usr --root=`pwd`/abdist --optimize=1
        if bool $NOPYTHON3
        then
                true
        else
                python2 setup.py clean
                python3 setup.py install --prefix=/usr --root=`pwd`/abdist --optimize=1
        fi
        # HACK! unset NOPYTHON3
        unset NOPYTHON3
}
export ABBUILDS="$ABBUILDS python"
