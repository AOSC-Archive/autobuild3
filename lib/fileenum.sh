abreqexe find
fileenum_fromstdin(){
	while true
	do
	read a
	[ "$a" = ":EXIT" ] && break
	[ "$a" = "" ] && continue
	eval `echo $1 | sed "s@{}@$a@g"`
	done
}
fileenum(){
	(find ; echo :EXIT) | fileenum_fromstdin "$*"
}
