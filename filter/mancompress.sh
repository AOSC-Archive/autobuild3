#!/bin/bash
##filter/mancompress.sh: Compresses manpages and break symlinks and boom
##@license GPL-2.0+
((ABMANCOMPRESS)) || return
set_opt globstar
gzip -9 "$PKGDIR"/usr/share/man/**/*.[0-9nl]
rec_opt globstar
