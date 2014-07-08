abrequire elf
elffltr_strip(){
	echo "Stripping $1 .."
	elf_strip $1
}
export ABELFFLTRS="$ABELFFLTRS strip"
