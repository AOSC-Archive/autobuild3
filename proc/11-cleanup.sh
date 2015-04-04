# Clean up!

if bool $ABCLEAN; then
    abinfo "Pre-build clean up..."
    rm -rf abdist
    rm -rf abscripts
    rm -f abspec
else 
    true
fi
