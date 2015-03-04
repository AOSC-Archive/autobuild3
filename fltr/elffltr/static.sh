if bool $NOSTATIC; then
    abinfo "Purging static libraries from build tree."
    rm -fv `find $PKGDIR -name '*.a'`
else
    true
fi
