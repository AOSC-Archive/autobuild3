abrequire fileenum elf
for i in $AB/fltr/elffltr/*.sh
do
	. $i
done
fltr_elffltr__process(){
	elf_iself "$*" || return 0
	[ "$ABELFFLTRS" = "" ] && return 0
	echo "Found ELF File: $*"
	for i in $ABELFFLTRS
	do
		echo "Processing $i on $*"
		elffltr_$i "$*"
	done
}
fltr_elffltr(){
	for i in usr/lib lib bin usr/bin opt/*/lib opt/*/bin
	do
		[ -d $i ] && (
		pushd $i >/dev/null
		fileenum "fltr_elffltr__process {}"
		popd >/dev/null
		)
	done
}

export ABFLTRS="$ABFLTRS elffltr"
