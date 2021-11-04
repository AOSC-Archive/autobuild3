#!/bin/bash
##filter/retro_drop_docs.sh: Drop /usr/share/{,gtk-}doc for Retro architectures.
##@copyright GPL-2.0+
filter_retro_drop_docs() {
	if [[ "${CROSS:-$ARCH}" = "armv4" || \
	      "${CROSS:-$ARCH}" = "armv6hf" || \
	      "${CROSS:-$ARCH}" = "armv7hf" || \
	      "${CROSS:-$ARCH}" = "i486" || \
	      "${CROSS:-$ARCH}" = "loongson2f" || \
	      "${CROSS:-$ARCH}" = "powerpc" || \
	      "${CROSS:-$ARCH}" = "ppc64" ]]; then
		if [ -d "$PKGDIR"/usr/share/doc ]; then
			abinfo "Dropping documentation ..."
			rm -r "$PKGDIR"/usr/share/doc
		fi

		if [ -d "$PKGDIR"/usr/share/gtk-doc ]; then
			abinfo "Dropping gtk-doc ..."
			rm -r "$PKGDIR"/usr/share/gtk-doc
		fi
	else
		abinfo "Non-Retro architectures detected, skipping retro_drop_docs ..."
	fi
}

export ABFILTERS+=" retro_drop_docs"
