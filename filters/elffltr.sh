abrequire fileenum elf
fltr_elffltr__process(){
	elf_iself "$*" || return 0
	[ "$ABELFFLTRS" = "" ] && return 0
	for i in $ABELFFLTRS
	do
		$i "$*"
	done
}
fltr_elffltr(){
	for i in usr/lib lib bin usr/bin opt/*/lib opt/*/bin
	do
		pushd $i
		fileenum "fltr_elffltr__process {}"
		popd
	done
}

export ABFLTRS="$ABFLTRS elffltr"
