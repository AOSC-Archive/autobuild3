# Still, let's use ABMK. MAKEFLAGS should be in defines.
if bool $NOPARALLEL; then
	abwarn "Parallel build DISABLED, get a cup of coffee, now!"
else
	abinfo "Parallel build ENABLED"
	ABMK+=" -j$(( $(nproc) * 2 + 1)) "
fi
