abrequire fileenum elf

for i in $AB/filter/elf/*.sh
do
	. "$i"
done

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
	for i in $PKGDIR/{opt/*/,usr/,}{lib{,64,exec},bin,sbin}
	do
		[ -d "$i" ] || continue
		pushd "$i" >/dev/null
		fileenum "filter_elffilter__process {}"
		popd >/dev/null
	done
}

export ABFILTERS+=" elf"
