#!/bin/bash
##filter/mancompress.sh: Compresses manpages and break symlinks and boom
##@copyright GPL-2.0+
((ABMANCOMPRESS)) || return
__mancomp_todo=()

if [ -d "$PKGDIR"/usr/share/man ]; then
	for i in "$PKGDIR"/usr/share/man/**/*.*; do
		if [[ -L $i ]]; then
			__mancomp_lnk=$(namei "$i" | tail -1 | awk '{print $NF}')
			rm "$i"
			ln -sf "$__mancomp_lnk".xz "$i"
		elif [[ -f $i ]]; then
			__mancomp_todo+=("$i")
		else
			abwarn "abmancomp WTF for ${i#"$PKGDIR"}"
		fi
	done

	abinfo "Compressing man page ${__mancomp_todo[@]} ..."
	xz -6e -- "${__mancomp_todo[@]}"
fi

unset __mancomp_todo __mancomp_lnk
