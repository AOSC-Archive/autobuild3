#!/bin/bash
##filter/infocompress.sh: Compresses Texinfo pages
##@copyright GPL-2.0+
filter_infocompress() {
	((ABINFOCOMPRESS)) || return
	__infocomp_todo=()

	if [ -d "$PKGDIR"/usr/share/info ]; then
		for i in "$PKGDIR"/usr/share/info/*.info; do
			if [[ -L $i ]]; then
				__infocomp_lnk=$(namei "$i" | tail -1 | awk '{print $NF}')
				rm "$i"
				ln -sf "$__infocomp_lnk".xz "$i"
			elif [[ -f $i ]]; then
				__infocomp_todo+=("$i")
			else
				abwarn "abinfocomp WTF for ${i#"$PKGDIR"}"
			fi
		done

		abinfo "Compressing Texinfo page ${__infocomp_todo[@]} ..."
		xz -6e -- "${__infocomp_todo[@]}"
	fi

	unset __infocomp_todo __infocomp_lnk
}

ABFILTERS+=" infocompress"
