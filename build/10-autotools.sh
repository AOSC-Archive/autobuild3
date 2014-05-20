abreqexe autoconf automake

SRCDIR=`pwd`

build_autotools_probe(){
	[ -f configur ] || [ -f autogen.sh ] || [ -f configure.ac ]
}

build_autotools_build() {
	if [ ! -e configure ]
	then
		printf "\033[36m>>>\033[0m The configure script does not present, attempting to run autogen or autoreconf... 		"
		if [ -e autogen.sh ]
		then
			NOCONFIGURE=1 ./autogen.sh > /dev/null
			if [ $? -ne 0 ]
			then
				printf "\033[31m[FAILED]\n\033[0m"
				printf "\033[33m-!- Error(s) occurred during the autogen.sh process\n\033[0m"
				exit 1
			else
				printf "\033[32m[OK]\n\033[0m"
				true
			fi
		elif [ -e configure.ac ]
		then 
			autoreconf -fi 2> /dev/null
			if [ $? -ne 0 ]
			then
				printf "\033[31m[FAILED]\n\033[0m"
				printf "\033[33m-!- Error(s) occurred during autoreconf\n\033[0m"
			else
				printf "\033[32m[OK]\n\033[0m"
			fi
		fi
	else
		 printf "\033[31m[FAILED]\n\033[0m"
		 printf "\033[33m-!- It's not an autotools source tree is it?\n\033[0m"
	fi

	if bool $ABSHADOW
	then
		mkdir -p build 2> /dev/null&&
		cd build
	else 
		true
	fi

	printf "\033[36m>>>\033[0m Running configure...		"
	$SRCDIR/configure $AUTOTOOLS_DEF $AUTOTOOLS_AFTER 
	if [ $? -ne 0 ]
	then
		printf "\033[31m[FAILED]\n\033[0m"
		printf "\033[33m-!- Error(s) occurred while running configure! Please check config.log in build/ or `pwd` if you exported ABSHADOW=no\n\033[0m"
	else
		printf "\033[32m[OK]\n\033[0m"
	fi
	printf "\033[36m>>>\033[0m Compile/Making source...		"
	make $ABMK $MAKE_AFTER > /dev/null
	if [ $? -ne 0 ]
	then
		printf "\033[31m[FAILED]\n\033[0m"
		printf "\033[33m-!- Error(s) occured while running make `echo $ABMK` `echo $MAKE_AFTER`\n\033[0m"
	else 
		printf "\033[32m[OK]\n\033[0m"
	fi
	printf "\033[36m>>>\033[0m Installing binaries/output to `echo $SRCDIR`/abdist ...	"
	make install DESTDIR=$SRCDIR/abdist $MAKE_AFTER
	if [ $? -ne 0 ]
	then
		printf "\033[31m[FAILED]\n\033[0m"
		printf "\033[33m-!- Error(s) occurred while running make install DESTDIR=`echo $SRCDIR/abdist` `echo $MAKE_AFTER`\n\033[0m"
	else
		printf "\033[32m[OK]\n\033[0m"
	fi
	
	if bool $ABSHADOW
	then 
		cd ..
	else
		true
	fi
}

export ABBUILDS="$ABBUILDS autotools"
