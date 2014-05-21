abreqexe perl
build_perl_probe(){
	[ -f Makefile.PL ]
}
build_prel_build(){
	printf "\033[36m>>>\033[0m Building Perl project... 		"
	perl Makefile.PL 
	if [ $? -ne 0 ]
	then
		printf "\033[31m[FAILED]\n\033[0m"
		printf "\033[33m-!- Error(s) occurred while compiling Perl source!\033[0m"
	else
		printf "\033[32m[OK]\n\033[0m"
	fi
	printf "\033[36m>>>\033[0m Installing Perl project..."
	make && make DESTDIR=`pwd`/abdist install
	if [ $? -ne 0 ]
	then
		printf "\033[31m[FAILED]\n\033[0m"
		printf "\033[33m-!- Error(s) occurred while installing Perl project\n\033[0m"
	else
		printf "\033[32m[OK]\n\033[0m"
	fi
}
export ABBUILDS="$ABBUILDS perl"
