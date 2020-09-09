#!/bin/bash
##15-rust.sh: Builds Rust + Cargo projects
##@copyright GPL-2.0+

abtryexe rustc cargo || ((!ABSTRICT)) || ablibret

LTO_INJECT_FAIL_MSG='Unable to inject LTO directives to Cargo.toml: please manually add `lto = true` under [profile.release] section.'

build_rust_probe(){
	[ -f Cargo.toml ]
}

build_rust_inject_lto() {
        $(bool ${USECLANG}) || abdie 'Please set `USECLANG=1` in your defines to enable proper LTO.'
        command -v ld.lld > /dev/null || abdie 'Please add `llvm` to your $BUILDDEP to enable proper LTO.'
	abinfo 'Injecting Rust LTO directives...'
	grep 'lto = true' Cargo.toml > /dev/null 2>&1 && abinfo "LTO directive already exists" && return
	# parsing TOML in bash will be hard
	grep 'profile.release' Cargo.toml > /dev/null 2>&1 && abdie "$LTO_INJECT_FAIL_MSG"
	echo -e "[profile.release]\nlto = true\n" >> Cargo.toml
}

build_rust_audit() {
	abinfo 'Auditing dependencies...'
	if ! command -v cargo-audit > /dev/null; then
		abwarn "cargo audit not found. Audit skipped"
	else
		[ -f Cargo.lock ] || abdie 'No lock file found -- Dependency information unreliable. Unable to conduct audit.'
		cargo audit || abdie 'Vulnerabilities detected! Refusing to continue.'
	fi
}

build_rust_build(){
	BUILD_START
	[ -f Cargo.lock ] || abwarn "This project is lacking the lock file. Please report this issue to the upstream."
	$(bool $NOLTO) || build_rust_inject_lto
	BUILD_READY
	abinfo 'Building...'
	cargo build --release $CARGO_AFTER || abdie "Compilation failed: $?"
	build_rust_audit
	abinfo 'Installing...'
	install -vd "$PKGDIR/usr/bin/"
	find target/release/ -maxdepth 1 -type f -not -name '*.*' -exec 'install' '-Dvm755' '{}' "$PKGDIR/usr/bin/" ';' || abdie "install failed: $?"
	BUILD_FINAL
}
ABBUILDS+=' rust'
