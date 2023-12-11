#!/bin/bash
##15-rust.sh: Builds Rust + Cargo projects
##@copyright GPL-2.0+

abtryexe rustc cargo || ((!ABSTRICT)) || ablibret

DEFAULT_CARGO_CONFIG=(
--config 'profile.release.lto = true'
--config 'profile.release.incremental = false'
--config 'profile.release.codegen-units = 1'
)

build_rust_prepare_registry() {
	local REGISTRY_URL='https://github.com/rust-lang/crates.io-index'
	local REGISTRY_DIR='github.com-1ecc6299db9ec823'
	local THIS_REGISTRY_DIR="$HOME/.cargo/registry/index/${REGISTRY_DIR}/.git"

	if [ ! -d "${THIS_REGISTRY_DIR}" ]; then
		git clone --bare "${REGISTRY_URL}" "${THIS_REGISTRY_DIR}"
	fi
}

build_rust_get_installed_rust_version() {
    rustc --version | perl -ne '/^rustc\s+(\d+\.\d+\.\d+)\s+\(/ && print"$1\n"'
}

build_rust_probe(){
	[ -f "$SRCDIR"/Cargo.toml ]
}

build_rust_inject_lto() {
	bool "${USECLANG}" \
		|| abdie 'Please set "USECLANG=1" in your defines to enable proper LTO.'
	if ! command -v ld.lld > /dev/null; then
		aberr 'ld.lld is unavailable. Please add "llvm" to your $BUILDDEP to enable proper LTO.'
		abdie 'If the architecture does not have ld.lld support, please disable LTO for this architecture.'
	fi
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
        cargo build "${DEFAULT_CARGO_CONFIG[@]}" --release --locked $CARGO_AFTER || abdie "Compilation failed: $?."
        if [ -e "$SRCDIR"/target/release/*.so* ]; then
		        abinfo "Installing lib in the workspace ..."
                install -Dvm755 "$SRCDIR"/target/release/*.so* \
                        -t "$PKGDIR"/usr/lib/
        fi
        abinfo "Installing binaries in the workspace ..."
        find "$SRCDIR"/target/release -maxdepth 1 -executable -type f ! -name "*.so" -exec 'install' '-Dvm755' '{}' "$PKGDIR/usr/bin/" ';'
}


build_rust_build(){
	BUILD_START
	[ -f "$SRCDIR"/Cargo.lock ] \
		|| abwarn "This project is lacking the lock file. Please report this issue to the upstream."
	if ! dpkg --compare-versions "$(build_rust_get_installed_rust_version)" ge '1.70.0'; then
		build_rust_prepare_registry
	fi
	if [[ "${CROSS:-$ARCH}" != "ppc64" ]] && \
		! bool "$NOLTO"; then
		build_rust_inject_lto
	fi

	# FIXME: cargo-audit >= 0.18 uses rustls, which breaks non-amd64/arm64 architectures.
	if [[ "${CROSS:-$ARCH}" = "amd64" || "${CROSS:-$ARCH}" = "arm64" ]] && \
		! bool "$NOCARGOAUDIT"; then
		build_rust_audit
	fi

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
