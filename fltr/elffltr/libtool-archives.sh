if bool $NOLIBTOOL; then
    abinfo "Purging libtool archives from build tree."
    rm -fv `find $PKGDIR -name '*.la'`
else
    true
fi
