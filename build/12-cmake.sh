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
	printf "\033[36m>>>\033[0m Running CMake... 		[INFO]"
	cmake $SRCDIR $CMAKE_DEF $CMAKE_AFTER && 
	printf "\033[36m>>>\033[0m Running make to build project... 		"
	make $ABMK $MAKE_AFTER && 
	if [ $? -ne 0 ]
	then
		printf "\033[31m[FAILED]\n\033[0m"
		printf "\033[33m-!- Error(s) occurred while running make `echo $ABMK` `echo $MAKE_AFTER` !\n\033[0m"
	else 
		printf "\033[32m[OK]\n\033[0m"
	fi
	printf "\033[36m>>>\033[0m Installing output/binaries to package area...	"
	make DESTDIR=$SRCDIR/abdist $MAKE_AFTER install
	if [ $? -ne 0 ]
	then
		printf "\033[31m[FAILED]\n\033[0m"
		printf "\033[33m-!- Error(s) occurred while installing output/binary!\n\033[0m"
	else
		printf "\033[32m[OK]\n\033[0m"
	fi
	if bool $ABSHADOW_CMAKE
	then
		cd ..
	fi
}
export ABBUILDS="$ABBUILDS cmake"
