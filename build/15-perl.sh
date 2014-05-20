abreqexe perl
build_perl_probe(){
	[ -f Makefile.PL ]
}
build_prel_build(){
	perl Makefile.PL
	make && make DESTDIR=`pwd`/abdist install
}
export ABBUILDS="$ABBUILDS perl"
