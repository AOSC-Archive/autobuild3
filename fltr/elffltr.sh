abrequire fileenum elf
for i in $AB/fltr/elffltr/*.sh
do
	. $i
done
fltr_elffltr__process(){
	elf_iself "$*" || return 0
	[ "$ABELFFLTRS" = "" ] && return 0
	printf "\033[36m>>>\033[0m Found ELF File		\033[33m[INFO]\033[0m\n $*"
	for i in $ABELFFLTRS
	do
		printf "\033[36m>>>\033[0m Processing $i on $*		[OK]\n"
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
