# MAKEFLAGS usage. ABMK as supplement.
if bool $NOPARALLEL; then
    abwarn "Parallel build DISABLED, get a cup of coffee, now!"
    sleep 2
    export MAKEFLAGS=
else
    abinfo "Parallel build ENABLED"
    export MAKEFLAGS="-j $(( $(nproc) * 2 + 1))"
fi
