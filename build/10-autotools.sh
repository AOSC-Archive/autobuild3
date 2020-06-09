#!/bin/bash
# 10-autotools.sh: Builds GNU autotools stuffs
##@copyright GPL-2.0+
abtryexe autoconf automake autoreconf

export FORCE_UNSAFE_CONFIGURE=1
# SRCDIR=`pwd`

build_autotools_probe(){
	[ -x "${configure=configure}" ] || [ -x autogen.sh ] || [ -x bootstrap ] || [ -f configure.ac ]
	# Seems that you can't use it this way.
}

build_autotools_build() {
	export ABSHADOW

	if bool $ABCONFIGHACK
	then
		for i in $(find "$SRCDIR" -name config.guess -o -name config.sub); do \
			abinfo "Copying replacement $i ..."
			# FIXME: hard-coded automake version.
			# Adapted from redhat-rpm-config.
			# http://pkgs.fedoraproject.org/cgit/rpms/redhat-rpm-config.git/tree/macros#n35
			cp -v /usr/share/automake-1.16/$(basename $i) $i ; \
		done
	fi

	if bool $RECONF
	then
		[ -x bootstrap ] && ! [ -e autogen.sh ] && ln -s bootstrap autogen.sh
		if [ ! -x "$configure" ] || [ -e .patch ]; then
			if [ -x autogen.sh ]; then
				NOCONFIGURE=1 ./autogen.sh | ablog
			elif [ -e configure.ac ]; then
				autoreconf -fvis -Wcross 2>&1 | ablog
			else
				abwarn 'Necessary files not found for script regeneration - non-standard Autotools source?'
			fi || abdie 'Reconfiguration failed: $?.'
		fi
	fi

	abinfo "Touching configure to avoid Automake timestamping issue ..."
	touch "$SRCDIR"/configure

	if bool $ABSHADOW
	then
		rm -rf build
		mkdir -p build || abdie "Failed creating \$SRCDIR/build"
		cd build
	fi

	if [[ $ABHOST != $ABBUILD ]]
	then
		AUTOTOOLS_TARGET="--host=$HOST"
	else
		AUTOTOOLS_TARGET="--build=${ARCH_TARGET[$ARCH]}"
	fi

	BUILD_START
	if bool $AUTOTOOLS_STRICT; then
		$SRCDIR/${configure:=configure} $AUTOTOOLS_TARGET $AUTOTOOLS_DEF $AUTOTOOLS_AFTER \
			--enable-option-checking=fatal | ablog
                returns $PIPESTATUS || abdie "Configuring failed."
	else
		$SRCDIR/${configure:=configure} $AUTOTOOLS_TARGET $AUTOTOOLS_DEF $AUTOTOOLS_AFTER | ablog
		returns $PIPESTATUS || abdie "Configuring failed."
	fi

	BUILD_READY
	make $ABMK $MAKE_AFTER | ablog
	returns $PIPESTATUS || abdie "Making failed."

	BUILD_FINAL
	make install BUILDROOT=$PKGDIR DESTDIR=$PKGDIR $MAKE_AFTER | ablog
	returns $PIPESTATUS || abdie "Installing failed."

	if bool $ABSHADOW
	then
		cd ..
	fi
}

ABBUILDS+=' autotools'
