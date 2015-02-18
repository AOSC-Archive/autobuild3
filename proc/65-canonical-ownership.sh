mkdir -p $PKGDIR/var/ab/canonical-ownership

for enlist in `find abdist/`; do 
    stat -c "%n %a %u %g" $enlist; done | cut -c 7- > $PKGDIR/var/ab/canonical-ownership/$PKGNAME
