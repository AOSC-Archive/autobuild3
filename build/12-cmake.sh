abtryexe cmake || ablibret

build_cmake_probe(){
	[ -f CMakeLists.txt ]
}

build_cmake_build(){
	local _ret
	: ${ABSHADOW_CMAKE=$ABSHADOW}
	if bool $ABSHADOW_CMAKE
	then
		rm -rf build
		mkdir build || abdie "Failed creating \$SRCDIR/build"
		cd build
	fi
	cmake $SRCDIR $CMAKE_DEF $CMAKE_AFTER && 
	make $ABMK $MAKE_AFTER && 
	make DESTDIR=$PKGDIR $MAKE_AFTER install || _ret=$?
	if bool $ABSHADOW_CMAKE
	then
		cd ..
	fi
	return $_ret
}
ABBUILDS+=cmake
