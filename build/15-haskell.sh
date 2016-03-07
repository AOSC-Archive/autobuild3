#!/bin/bash
##15-haskell.sh: Builds Haskell stuffs
##@copyright GPL-2.0+
abtryexe runhaskell ghc || ablibret

build_haskell_probe(){
	[ -f Setup.hs ] || [ -f Setup.lhs ]
}

build_haskell_build(){
	local _ret
	echo "/usr/share/haskell/$PKGNAME/register.sh" > autobuild/postinst
	echo "pushd /usr/share/doc/ghc/html/libraries; ./gen_contents_index; popd" >> autobuild/postinst
	echo "pushd /usr/share/doc/ghc/html/libraries; ./gen_contents_index; popd" >> autobuild/postrm
	# A reminder
	if bool "$NOSTATIC" && ! grep -q '^NOSTATIC=no' autobuild/defines; then
		echo "# This is Haskell" >> autobuild/defines
		echo "NOSTATIC=no" >> autobuild/defines
	fi
	# DO IT
	export NOSTATIC=no
	BUILD_START
	# Is it intended to, uh, mimic configure?
	runhaskell Setup configure -O -p \
		--enable-split-objs --enable-shared \
		--prefix=/usr --docdir=/usr/share/doc/$PKGNAME \
		--libsubdir=\$compiler/site-local/\$pkgid
	BUILD_READY
	runhaskell Setup build $MAKE_AFTER
	runhaskell Setup haddock
	runhaskell Setup register --gen-script
	runhaskell Setup unregister --gen-script
	sed -i -r -e "s|ghc-pkg.*unregister[^ ]* |&'--force' |" unregister.sh
	BUILD_FINAL
	install -D -m744 register.sh $PKGDIR/usr/share/haskell/$PKGNAME/register.sh
	install -m744 unregister.sh $PKGDIR/usr/share/haskell/$PKGNAME/unregister.sh
	install -d -m755 $PKGDIR/usr/share/doc/ghc/html/libraries
	ln -s /usr/share/doc/$PKGNAME/html $PKGDIR/usr/share/doc/ghc/html/libraries/$PKGNAME
	runhaskell Setup copy --destdir=$PKGDIR
}

ABBUILDS+=' haskell'
