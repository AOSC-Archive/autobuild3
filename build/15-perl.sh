abreqexe perl
build_perl_probe(){
	[ -f Makefile.PL ]
}
build_perl_build(){
	yes | perl Makefile.PL 
	yes | make && 
	make DESTDIR=$PKGDIR install
}
export ABBUILDS="$ABBUILDS perl"
