#!/bin/bash
# 10-autotools.sh: Builds GNU autotools stuff
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

	if bool "$ABCONFIGHACK"
	then
		for i in $(find "$SRCDIR" -name config.guess -o -name config.sub); do \
			abinfo "Copying replacement $i ..."
			# FIXME: hard-coded automake version.
			# Adapted from redhat-rpm-config.
			# http://pkgs.fedoraproject.org/cgit/rpms/redhat-rpm-config.git/tree/macros#n35
			cp -v "/usr/share/automake-1.16/$(basename "$i")" "$i" ; \
		done
	fi

	if bool "$RECONF"
	then
		abinfo "Re-generating Autotools scripts ..."
		[ -x bootstrap ] && ! [ -e autogen.sh ] && ln -s bootstrap autogen.sh
		if [[ -x bootstrap && ! -d bootstrap ]]; then
			"$SRCDIR/bootstrap" || abdie "Reconfiguration failed: $?."
		elif [[ -x autogen.sh && ! -d autogen.sh ]]; then
			NOCONFIGURE=1 "$SRCDIR/autogen.sh" || abdie "Reconfiguration failed: $?."
		elif [ -e configure.ac ] || [ -e configure.in ]; then
			autoreconf -fvis 2>&1 || abdie "Reconfiguration failed: $?."
		else
			abdie 'Necessary files not found for script regeneration - non-standard Autotools source?'
		fi
	fi

	if bool "$ABSHADOW"
	then
		rm -rf build
		abinfo "Creating directory for shadow build ..."
		mkdir -p build || abdie "Failed creating \$SRCDIR/build"
		cd build || abdie "Unable to cd to build"
	fi

	if [[ "$ABHOST" != "$ABBUILD" ]]
	then
		AUTOTOOLS_TARGET="--host=$HOST"
	else
		AUTOTOOLS_TARGET="--build=${ARCH_TARGET[$ARCH]}"
	fi

	BUILD_START
	abinfo "Running configure ..."
	if bool "$AUTOTOOLS_STRICT"; then
		"$SRCDIR"/${configure:=configure} $AUTOTOOLS_TARGET $AUTOTOOLS_DEF $AUTOTOOLS_AFTER \
			--enable-option-checking=fatal || abdie "Configuring failed."
	else
		abwarn "Strict Autotools option checking disabled !!"
		"$SRCDIR"/${configure:=configure} $AUTOTOOLS_TARGET $AUTOTOOLS_DEF $AUTOTOOLS_AFTER \
			|| abdie "Configuring failed."
	fi

	BUILD_READY
	abinfo "Building binaries ..."
	make V=1 VERBOSE=1 $ABMK $MAKE_AFTER || abdie "Making failed."

	BUILD_FINAL
	abinfo "Installing binaries ..."
	make install V=1 VERBOSE=1 BUILDROOT="$PKGDIR" DESTDIR="$PKGDIR" $MAKE_AFTER \
		|| abdie "Installing failed."

	if bool "$ABSHADOW"
	then
		cd "$SRCDIR" || abdie "Unable to cd to $SRCDIR: $?."
	fi
}

ABBUILDS+=' autotools'
