# Clean up!

# TODO: Different build type specific clean up.

if bool $ABCLEAN; then
	abinfo "Pre-build clean up..."
	rm -rf $SRCDIR/abdist
	rm -rf $SRCDIR/abscripts
	rm -f $SRCDIR/abspec
else 
	true
fi
