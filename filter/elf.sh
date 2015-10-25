#!/bin/bash
##filter/elf.sh: ELF-related filters
##@copyright GPL-2.0+
abrequire elf

recsr $AB/filter/elf/*.sh

filter_elf__process(){
	local _elf_f
	elf_iself "$@" || return 0
	[ -z "$ABELFFILTERS" ] && return 0
	for _elf_f in $ABELFFILTERS
	do
		filter_elf_$_elf_f "$@" || abwarn "$(argprint filter_elf_$_elf_f "$@"): $?"
	done
}

filter_elf(){
	local _elf_f _elf_cmd
	for _elf_f in $ABELFFILTER; do _elf_cmd=filter_elf_${_elf_f}_pre; ! _which $_elf_cmd &>/dev/null || $_elf_cmd || abwarn "$(argprint $_elf_cmd "$@"): $?"; done
	set_opt nullglob # Force existing(nullglob) directories(/).
	for i in "$PKGDIR"/{[o]pt/*/,[u]sr/,}{[l]ib{,64,exec},{s,}[b]in}/**
	do
		filter_elf__process "$i"
	done
	cd "$PKGDIR"
	for _elf_f in $ABELFFILTER; do _elf_cmd=filter_elf_${_elf_f}_post; ! _which $_elf_cmd &>/dev/null || $_elf_cmd || abwarn "$(argprint $_elf_cmd "$@"): $?"; done
	rec_opt nullglob
}

export ABFILTERS+=" elf"
