# MAKEFLAGS usage. ABMK as supplement.
if bool $NOPARALLEL; then
    export MAKEFLAGS=
else
    export MAKEFLAGS="-j $(echo $(lscpu | grep ^CPU\(s\) | awk '{ print $2 }')*2+1 | bc)"
fi
