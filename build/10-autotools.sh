abreqexe autoconf automake

SRCDIR=`pwd`

build_autotools_probe(){
	[ -f configure ] || [ -f autogen.sh ] || [ -f configure.ac ]
}

build_autotools_build() {
	[ "$ABSHADOW" != "" ] && export ABSHADOW_AUTOTOOLS=$ABSHADOW
	if [ ! -e configure ]
	then
		if [ -e autogen.sh ]
		then
			NOCONFIGURE=1 ./autogen.sh | ablog
		elif [ -e configure.ac ]
		then 
			autoreconf -fi 2>&1 | ablog
		fi
	else
		# a configure script is already present
		true
	fi

	if bool $ABSHADOW_AUTOTOOLS
	then
		mkdir -p build 2> /dev/null&&
		cd build
	else 
		true
	fi

	$SRCDIR/configure $AUTOTOOLS_DEF $AUTOTOOLS_AFTER  | ablog
	make $ABMK $MAKE_AFTER | ablog
	make install DESTDIR=$SRCDIR/abdist $MAKE_AFTER | ablog
	
	if bool $ABSHADOW_AUTOTOOLS
	then 
		cd ..
	else
		true
	fi
}

export ABBUILDS="$ABBUILDS autotools"
