abreqexe cmake
build_cmake_probe(){
	[ -f CMakeLists.txt ]
}
build_cmake_build(){
	[ "x$ABSHADOW" != "x" ] && export ABSHADOW_CMAKE=$ABSHADOW
	export SRCDIR=`pwd`
	if bool $ABSHADOW_CMAKE
	then
		mkdir -p build
		cd build
	fi
	cmake $SRCDIR $CMAKE_DEF $CMAKE_AFTER && 
	make $ABMK $MAKE_AFTER && 
	make DESTDIR=$SRCDIR/abdist $MAKE_AFTER install
	if bool $ABSHADOW_CMAKE
	then
		cd ..
	fi
}
export ABBUILDS="$ABBUILDS cmake"
