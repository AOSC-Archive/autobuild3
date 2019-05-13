#!/bin/bash
# 13-cmakeninja.sh: Builds cmake with Ninja
##@copyright GPL-2.0+
(abtryexe cmake && abtryexe ninja) || ablibret

build_cmakeninja_probe(){
	[ -f CMakeLists.txt ]
}

build_cmakeninja_build(){
	local _ret
	ABSHADOW=${ABSHADOW_CMAKE-$ABSHADOW}
	if bool $ABSHADOW
	then
		rm -rf build
		mkdir build || abdie "Failed creating \$SRCDIR/build"
		cd build
	fi
	BUILD_START
	cmake $SRCDIR $CMAKE_DEF $CMAKE_AFTER -GNinja
	BUILD_READY
	ninja $ABMK $MAKE_AFTER
	BUILD_FINAL
	DESTDIR=$PKGDIR ninja install || _ret=$PIPESTATUS
	if bool $ABSHADOW
	then
		cd ..
	fi
	return $_ret
}
ABBUILDS+=' cmakeninja'
