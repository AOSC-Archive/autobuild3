#!/bin/bash
##15-rust.sh: Builds Rust + Cargo projects
##@copyright GPL-2.0+

abtryexe rustc cargo || ((!ABSTRICT)) || ablibret

build_rust_prepare_registry() {
	local REGISTRY_URL='https://github.com/rust-lang/crates.io-index'
	local REGISTRY_DIR='github.com-1ecc6299db9ec823'
	local THIS_REGISTRY_DIR="$HOME/.cargo/registry/index/${REGISTRY_DIR}/.git"

	if [ ! -d "${THIS_REGISTRY_DIR}" ]; then
		git clone --bare "${REGISTRY_URL}" "${THIS_REGISTRY_DIR}"
	fi
}

build_rust_probe(){
	[ -f "$SRCDIR"/Cargo.toml ]
}

build_rust_inject_lto() {
        bool "${USECLANG}" \
		|| abdie 'Please set "USECLANG=1" in your defines to enable proper LTO.'
        command -v ld.lld > /dev/null \
		|| abdie 'ld.lld is unavailble. Please add "llvm" to your $BUILDDEP to enable proper LTO.'
}

build_rust_audit() {
	abinfo 'Setting up build environment: $PKG_CONFIG_SYSROOT_DIR= hack ...'
	export PKG_CONFIG_SYSROOT_DIR=/
	abinfo 'Auditing dependencies...'
	if ! command -v cargo-audit > /dev/null; then
		abdie "cargo-audit not found: $?."
	elif [ -f "$SRCDIR"/Cargo.lock ]; then
		if ! cargo audit; then
			abinfo 'Vulnerabilities detected! Attempting automatic fix ...'
			cargo audit fix \
				|| abdie 'Unable to fix vulnerability! Refusing to continue.'
		fi
	else
		abdie 'No lock file found -- Dependency information unreliable. Unable to conduct audit.'
	fi
}

fallback_build() {
	cargo build --config "profile.release.lto = true" --release --locked $CARGO_AFTER || abdie "Compilation failed: $?."
	abinfo "Installing binaries in the workspace ..."
	find "$SRCDIR"/target/release -maxdepth 1 -executable -exec 'install' '-Dvm755' '{}' "$PKGDIR/usr/bin/" ';'
}

build_rust_build(){
	BUILD_START
	[ -f "$SRCDIR"/Cargo.lock ] \
		|| abwarn "This project is lacking the lock file. Please report this issue to the upstream."
	build_rust_prepare_registry
	if [[ "${CROSS:-$ARCH}" != "ppc64" ]] && \
		! bool "$NOLTO"; then
		build_rust_inject_lto
	fi
	bool "$NOCARGOAUDIT" \
		|| build_rust_audit
	BUILD_READY
	abinfo 'Building Cargo package ...'
	install -vd "$PKGDIR/usr/bin/"
	if ! grep '\[workspace\]' Cargo.toml > /dev/null; then
		cargo install --locked -f --path "$SRCDIR" \
                              --config "profile.release.lto = true" \
			      --root="$PKGDIR/usr/" $CARGO_AFTER \
			|| abdie "Compilation failed: $?."
	else
		abinfo 'Using fallback build method ...'
		fallback_build
	fi
	abinfo 'Dropping lingering files ...'
	rm -v "$PKGDIR"/usr/.crates{.toml,2.json}
	BUILD_FINAL
}

ABBUILDS+=' rust'
