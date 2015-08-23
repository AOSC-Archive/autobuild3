abtryexe autoconf automake autoreconf

export FORCE_UNSAFE_CONFIGURE=1
# SRCDIR=`pwd`

build_autotools_probe(){
	[ -x "${configure=configure}" ] || [ -x autogen.sh ] || [ -x bootstrap ] || [ -f configure.ac ]
	# Seems that you can't use it this way.
}

build_autotools_build() {
	export ABSHADOW

	if bool $RECONF
	then
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
	fi

	if bool $ABSHADOW
	then
		rm -rf build
		mkdir -p build || abdie "Failed creating \$SRCDIR/build"
		cd build
	fi

	if [ "$CROSS" ]
	then
		AUTOTOOLS_TARGET="--host=$HOST"
	fi

	BUILD_START
	$SRCDIR/$configure $AUTOTOOLS_TARGET $AUTOTOOLS_DEF $AUTOTOOLS_AFTER | ablog
	# QUIRK: a bug found in most GNOME packages.
	if bool $ABSHADOW
	then
	        sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' $SRCDIR/build/libtool
	else
		sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool
	fi

	BUILD_READY
	make $ABMK $MAKE_AFTER | ablog

	BUILD_FINAL
	make install BUILDROOT=$PKGDIR DESTDIR=$PKGDIR $MAKE_AFTER | ablog || _ret=$?

	if bool $ABSHADOW
	then
		cd ..
	fi
	return $_ret
}

ABBUILDS+=' autotools'
