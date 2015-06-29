abrequire elf

filter_elf_strip(){
	bool $ABSTRIP || return 0
	abdbg "Stripping $1 .."
	elf_strip $1
}

export ABELFFILTERS="$ABELFFILTERS strip"
