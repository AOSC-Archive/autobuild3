# Clean up!

abinfo "Pre-build clean up..."
if bool $ABCLEAN; then
    rm -rf abdist
    rm -rf abscripts
    rm -f abspec
else 
    true
fi
