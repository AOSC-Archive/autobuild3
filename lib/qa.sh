qa(){
	bool $ABQA
}
qa_die(){
	abdie "QA Error: $*"
}
qa_inset(){
	grep '^'"$1"'$' $AB/sets/section >/dev/null
}
qa_clean(){
  ! ([ -e $PKGDIR/usr/local])
}