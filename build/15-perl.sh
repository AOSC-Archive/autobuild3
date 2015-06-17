abreqexe perl
build_perl_probe(){
	[ -f Makefile.PL ]
}
build_perl_build(){
	yes | perl Makefile.PL &&
	yes | make $MAKE_AFTER && 
	make DESTDIR=$PKGDIR install
}
export ABBUILDS="$ABBUILDS perl"
