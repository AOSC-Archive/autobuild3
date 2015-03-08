abreqexe perl
build_perl_probe(){
	[ -f Makefile.PL ]
}
build_perl_build(){
	yes | perl Makefile.PL 
	yes | make && 
	make DESTDIR=`pwd`/abdist install
}
export ABBUILDS="$ABBUILDS perl"
