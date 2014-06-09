qa(){
	bool $ABQA
}
qa_die(){
	echo "QA Error: $*"
	exit 1
}
qa_inset(){
	grep '^'"$1"'$' $AB/sets/$2 >/dev/null
}
