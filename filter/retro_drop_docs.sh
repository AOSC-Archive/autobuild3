#!/bin/bash
##filter/retro_drop_docs.sh: Drop /usr/share/{,gtk-}doc for Retro architectures.
##@copyright GPL-2.0+
filter_retro_drop_docs() {
	if ab_match_archgroup retro; then
		if [ -d "$PKGDIR"/usr/share/doc ]; then
			abinfo "Dropping documentation ..."
			rm -r "$PKGDIR"/usr/share/doc
		fi

		# GTK-Doc stores Python modules in /usr/share/gtk-doc,
		# dropping this directory will render its tools unusable.
		if [[ "$PKGNAME" != "gtk-doc" && \
			-d "$PKGDIR"/usr/share/gtk-doc ]]; then
			abinfo "Dropping gtk-doc ..."
			rm -r "$PKGDIR"/usr/share/gtk-doc
		fi
	else
		abinfo "Non-Retro architectures detected, skipping retro_drop_docs ..."
	fi
}

export ABFILTERS+=" retro_drop_docs"
