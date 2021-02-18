#!/bin/bash
# 10-autotools.sh: Builds GNU autotools stuff
##@copyright GPL-2.0+
abtryexe autoconf automake autoreconf

export FORCE_UNSAFE_CONFIGURE=1

build_autotools_probe(){
	[ -x "${configure=$SRCDIR/configure}" ] || \
		[ -x "$SRCDIR"/autogen.sh ] || \
		[ -x "$SRCDIR"/bootstrap ] || \
		[ -f "$SRCDIR"/configure.ac ]
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
			cp -v "/usr/share/automake-1.16/$(basename "$i")" "$i" \
				|| abdie "Failed to copy replacement $i: $?."; \
		done
	fi

	if bool "$RECONF"
	then
		abinfo "Re-generating Autotools scripts ..."
		[ -x "$SRCDIR"/bootstrap ] && ! [ -e "$SRCDIR"/autogen.sh ] \
			&& ln -sv "$SRCDIR"/bootstrap "$SRCDIR"/autogen.sh
		if [[ -x "$SRCDIR"/bootstrap && ! -d "$SRCDIR"/bootstrap ]]; then
			"$SRCDIR/bootstrap" \
				|| abdie "Reconfiguration failed: $?."
		elif [[ -x "$SRCDIR"/autogen.sh && ! -d "$SRCDIR"/autogen.sh ]]; then
			NOCONFIGURE=1 "$SRCDIR/autogen.sh" \
				|| abdie "Reconfiguration failed: $?."
		elif [ -e "$SRCDIR"/configure.ac ] || [ -e "$SRCDIR"/configure.in ]; then
			autoreconf -fvis 2>&1 || abdie "Reconfiguration failed: $?."
		else
			abdie 'Necessary files not found for script regeneration - non-standard Autotools source?'
		fi
	fi

	if bool "$ABSHADOW"
	then
		abinfo "Creating directory for shadow build ..."
		mkdir -pv "$SRCDIR"/abbuild \
			|| abdie "Failed to create shadow build directory: $?."
		cd "$SRCDIR"/abbuild \
			|| abdie "Failed to enter shadow build directory: $?."
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
		"$SRCDIR"/${configure:=configure} \
			$AUTOTOOLS_TARGET $AUTOTOOLS_DEF $AUTOTOOLS_AFTER \
			--enable-option-checking=fatal \
			|| abdie "Failed to run configure: $?."
	else
		abwarn "Strict Autotools option checking disabled !!"
		"$SRCDIR"/${configure:=configure} \
			$AUTOTOOLS_TARGET $AUTOTOOLS_DEF $AUTOTOOLS_AFTER \
			|| abdie "Failed to run configure: $?."
	fi

	BUILD_READY
	abinfo "Building binaries ..."
	make V=1 VERBOSE=1 \
		$ABMK $MAKE_AFTER \
		|| abdie "Failed to build binaries: $?."

	BUILD_FINAL
	abinfo "Installing binaries ..."
	make install V=1 VERBOSE=1 \
		BUILDROOT="$PKGDIR" DESTDIR="$PKGDIR" $MAKE_AFTER \
		|| abdie "Failed to install binaries: $?."

	if bool "$ABSHADOW"
	then
		cd "$SRCDIR" \
			|| abdie "Unable to return to source directory: $?."
	fi
}

ABBUILDS+=' autotools'
