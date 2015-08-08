((ABMANCOMPRESS)) || return
set_opt globstar
gzip -9 "$PKGDIR"/usr/share/man/**/*.[0-9nl]
rec_opt globstar
