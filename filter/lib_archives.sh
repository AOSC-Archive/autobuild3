if bool $NOLIBTOOL; then
	abinfo "Purging libtool archives from build tree."
	find $PKGDIR -name '*.la' -delete || abwarn ".la purge: $?"
fi
if bool $NOSTATIC; then
	abinfo "Purging static libraries from build tree."
	find $PKGDIR -name '*.a' -delete || abwarn ".a purge: $?"
fi
