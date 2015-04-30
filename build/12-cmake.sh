abreqexe cmake
build_cmake_probe(){
	[ -f CMakeLists.txt ]
}
build_cmake_build(){
	[ "x$ABSHADOW" != "x" ] && export ABSHADOW_CMAKE=$ABSHADOW
	export SRCDIR=`pwd`
	if bool $ABSHADOW_CMAKE
	then
		rm -rf build
		mkdir build
		cd build
	fi
	cmake $SRCDIR $CMAKE_DEF $CMAKE_AFTER && 
	make $ABMK $MAKE_AFTER && 
	make DESTDIR=$PKGDIR $MAKE_AFTER install
	if bool $ABSHADOW_CMAKE
	then
		cd ..
	fi
}
export ABBUILDS="$ABBUILDS cmake"
