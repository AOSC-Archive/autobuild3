# MAKEFLAGS usage. ABMK as supplement.
if bool $NOPARALLEL; then
    abwarn "Parallel build DISABLED, get a cup of coffee, now!"
    sleep 2
    export MAKEFLAGS=
else
    abinfo "Parallel build ENABLED"
    export MAKEFLAGS="-j $(echo $(lscpu | grep ^CPU\(s\) | awk '{ print $2 }')*2+1 | bc)"
fi
