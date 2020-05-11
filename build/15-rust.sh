#!/bin/bash
##15-rust.sh: Builds Rust + Cargo projects
##@copyright GPL-2.0+

abtryexe rustc cargo || ((!ABSTRICT)) || ablibret

build_rust_probe(){
	[ -f Cargo.toml ]
}

build_rust_build(){
	BUILD_START
    [ -f Cargo.lock ] || abwarn "This project is lacking the lock file. Please report this issue to the upstream."
    abinfo 'Pre-flight checking...'
	cargo check $CARGO_AFTER
    BUILD_READY
    abinfo 'Building...'
	cargo build --release $CARGO_AFTER
    abinfo 'Installing...'
    install -d "$PKGDIR/usr/bin/"
    find target/release/ -maxdepth 1 -type f -not -name '*.*' -exec 'install' '-Dm755' '{}' "$PKGDIR/usr/bin/"
    BUILD_FINAL
}
ABBUILDS+=' rust'
