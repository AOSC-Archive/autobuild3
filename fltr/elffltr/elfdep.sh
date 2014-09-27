abrequire elf depset pm
elffltr_elfdep(){
	bool $ABELFDEP || return 0
	echo "Looking for Dependencies on $1 ..."
	export OLD_LC_ALL=$LC_ALL
	export LC_ALL=C
	ldd $1 | grep "not a dynamic executable" &>/dev/null && ab_dbg "Non-dynamic executable $1 sent into elfdep." && return
	ldd $1 | grep "not found" 2>/dev/null && abwarn "↑Missing library found in $1.↑" && return
	export LC_ALL=$OLD_LC_ALL
	for i in `ldd $1 | awk '{print $3}' | grep -v "^("`
	do
		i=`echo $i | sed 's@/lib64/@/lib/@g'`
		i=`echo $i | sed 's@/\.\./lib/@/@g'`
		P=`pm_whoprov $i`
		abdbg "pm_whoprov returned ${P-null} for $i"
		if [ "$P" != "$PKGNAME" ] && [ "$P" != "" ]; then; depset_add "$P"; fi
	done
}
export ABELFFLTRS="$ABELFFLTRS elfdep"
