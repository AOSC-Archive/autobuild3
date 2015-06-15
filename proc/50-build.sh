[ -f `arch_findfile prepare` ] && . `arch_findfile prepare`
build_${ABTYPE}_build

_ret=$?

[ -d `arch_findfile overrides` ] && cp -r `arch_findfile overrides`/* abdist/
[ -f `arch_findfile beyond` ] && . `arch_findfile beyond`

returns $_ret
