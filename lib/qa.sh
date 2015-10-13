#!/bin/bash
##qa.sh: QA scripts. Writing this as a library has to be a mistake.
##@license GPL-2.0+
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
