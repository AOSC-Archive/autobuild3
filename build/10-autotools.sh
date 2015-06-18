abtryexe autoconf automake autoreconf

export FORCE_UNSAFE_CONFIGURE=1
# SRCDIR=`pwd`

build_autotools_probe(){
	[ -x "${configure=configure}" ] || [ -x autogen.sh ] || [ -x bootstrap ] || [ -f configure.ac ]
	# Seems that you can't use it this way.
}

build_autotools_build() {
	[ $ABSHADOW ] && export ABSHADOW
	[ -x bootstrap ] && ! [ -e autogen.sh ] && ln -s bootstrap autogen.sh
	if [ ! -x "$configure" ] || [ -e .patch ]; then
		if [ -x autogen.sh ]; then
			NOCONFIGURE=1 ./autogen.sh | ablog
		elif [ -e configure.ac ]; then 
			autoreconf -fis -Wcross 2>&1 | ablog
		elif [ -e .patch ]; then
			abwarn "Source patched but configure not regenerated."
		else
			abdie "$configure is not executable and no fallbacks found."
		fi || abicu 'Reconfiguration failed: $?.'
	fi

	if bool $ABSHADOW
	then
		rm -rf build
		mkdir -p build || abdie "Failed creating \$SRCDIR/build"
		cd build
	fi
	
	if [ "x$CROSS" != "x" ]
	then
		AUTOTOOLS_CROSS=--host=$HOST
	fi

	$SRCDIR/$configure $AUTOTOOLS_CROSS $AUTOTOOLS_DEF $AUTOTOOLS_AFTER  | ablog &&
	make $ABMK $MAKE_AFTER | ablog &&
	make install BUILDROOT=$PKGDIR DESTDIR=$PKGDIR $MAKE_AFTER | ablog ||
	_ret=$?
	if bool $ABSHADOW
	then
		cd ..
	fi
	return $_ret
}

ABBUILDS+=' autotools'
