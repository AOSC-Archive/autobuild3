#!/bin/bash
##filter/mancompress.sh: Compresses manpages and break symlinks and boom
##@copyright GPL-2.0+
((ABMANCOMPRESS)) || return
set_opt globstar
__mancomp_todo=()
for i in "$PKGDIR"/usr/share/man/**/*.[0-9nl]; do
  if [[ -f $i ]]; then
    __mancomp_todo+=("$i")
  elif [[ -L $i ]]; then
    __mancomp_lnk=$(readlink  -- "$i")
    rm "$i"
    ln -sf "$__mancomp_lnk".gz "$i"
  else
    abwarn "abmancomp WTF for ${i#"$PKGDIR"}"
  fi
done
gzip -9 -- "${__to_comp[@]}"
unset __mancomp_todo __mancomp_lnk
rec_opt globstar
