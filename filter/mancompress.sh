#!/bin/bash
##filter/mancompress.sh: Compresses manpages and break symlinks and boom
##@copyright GPL-2.0+
filter_mancompress() {
	((ABMANCOMPRESS)) || return
	__mancomp_todo=()

	if [ -d "$PKGDIR"/usr/share/man ]; then
		for i in "$PKGDIR"/usr/share/man/**/*.*; do
			if [[ $i == *.gz || $i == *.bz2 || $i = *.zst || $i == *.xz ]]; then
				continue
			fi
		
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
		xz --lzma2=preset=6e,pb=0 -- "${__mancomp_todo[@]}"
	fi

	unset __mancomp_todo __mancomp_lnk
}

ABFILTERS+=" mancompress"
