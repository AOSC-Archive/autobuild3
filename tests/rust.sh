abtest_rust_test() {
    abinfo "Running cargo test ..."
    cargo test \
        --manifest-path "$SRCDIR/Cargo.toml" \
        --no-fail-fast -r \
        ${CARGO_TEST_AFTER}
}
