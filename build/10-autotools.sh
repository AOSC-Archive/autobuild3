abreqexe autoconf automake

export FORCE_UNSAFE_CONFIGURE=1
SRCDIR=`pwd`

build_autotools_probe(){
	[ -x configure ] || [ -x autogen.sh ] || [ -x bootstrap] || [ -f configure.ac ] # || [ -x $configure ]
											# Seems that you can't use it this way.
}

build_autotools_build() {
	[ $ABSHADOW ] && export ABSHADOW
	([ -x bootstrap ] && ! [ -e autogen.sh]) && ln -s bootstrap autogen.sh
	if [ ! -e configure ]; then
	  if [ -x autogen.sh ]; then
	    NOCONFIGURE=1 ./autogen.sh | ablog
	  elif [ -e configure.ac ]; then 
			autoreconf -fis 2>&1 | ablog
		fi
	fi

	if bool $ABSHADOW
	then
		mkdir -p build 2> /dev/null&&
		cd build
	fi

	$SRCDIR/configure $AUTOTOOLS_DEF $AUTOTOOLS_AFTER  | ablog &&
	make $ABMK $MAKE_AFTER | ablog &&
	make install BUILDROOT=$SRCDIR/abdist DESTDIR=$SRCDIR/abdist $MAKE_AFTER | ablog &&
	_ret=$?
	if bool $ABSHADOW
	then 
		cd ..
	fi
}

export ABBUILDS="$ABBUILDS autotools"
