abrequire elf
elffltr_strip(){
	bool $ABSTRIP || return 0
	elf_strip $1
}
export ABELFFLTRS="$ABELFFLTRS strip"
