abreqexe find

fileenum_fromstdin() {
	while read a; do
	[ "$a" = ":EXIT" ] && return
	[ "$a" = "" ] && continue
	eval `echo $1 | sed "s@{}@$a@g"`
	done
}

fileenum() {
	for i in `find .`
	do
		[ ! -e $i ] && continue
		eval `echo $1 | sed "s@{}@$i@g"`
	done
}
