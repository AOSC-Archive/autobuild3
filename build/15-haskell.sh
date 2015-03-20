abreqexe runhaskell ghc

build_haskell_probe(){
        [ -f Setup.hs ] || [ -f Setup.lhs ]
}
build_haskell_build(){
    echo "/usr/share/haskell/$PKGNAME/register.sh" > autobuild/postinst
    echo "cd /usr/share/doc/ghc/html/libraries; ./gen_contents_index" >> autobuild/postinst
    echo "cd /usr/share/doc/ghc/html/libraries; ./gen_contents_index" > autobuild/postrm
    # A reminder
    if grep ^NOSTATIC=no autobuild/defines >/dev/null; then
        true
    else
        echo "" >> autobuild/defines
        echo "NOSTATIC=no" >> autobuild/defines
    fi
    # Execute reminder
    export NOSTATIC=no
    runhaskell Setup configure -O -p \
                               --enable-split-objs --enable-shared \
                               --prefix=/usr --docdir=/usr/share/doc/$PKGNAME \
                               --libsubdir=\$compiler/site-local/\$pkgid
    runhaskell Setup build
    runhaskell Setup haddock
    runhaskell Setup register --gen-script
    runhaskell Setup unregister --gen-script
    sed -i -r -e "s|ghc-pkg.*unregister[^ ]* |&'--force' |" unregister.sh
    install -D -m744 register.sh `pwd`/abdist/usr/share/haskell/$PKGNAME/register.sh
    install -m744 unregister.sh `pwd`/abdist/usr/share/haskell/$PKGNAME/unregister.sh
    install -d -m755 `pwd`/abdist/usr/share/doc/ghc/html/libraries
    ln -s /usr/share/doc/$PKGNAME/html `pwd`/abdist/usr/share/doc/ghc/html/libraries/$PKGNAME
    runhaskell Setup copy --destdir=`pwd`/abdist
}

export ABBUILDS="$ABBUILDS haskell"
