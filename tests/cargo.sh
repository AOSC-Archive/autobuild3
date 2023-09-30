abtest_cargo_run() {
    abinfo "Running cargo test ..."
    cargo test \
        --path "$SRCDIR/Cargo.toml" \
        --no-fail-fast -r \
        ${CARGO_TEST_AFTER}
}
