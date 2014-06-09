abrequire elf depset pm
elffltr_elfdep(){
	bool $ABELFDEP || return 0
	echo "Looking for Dependencies on $1 ..."
	export OLD_LC_ALL=$LC_ALL
	export LC_ALL=C
	if ldd $1 | grep "not a dynamic executable" > /dev/null 2>&1
	then
		return
	fi
        if ldd $1 | grep "not found" > /dev/null 2>&1
        then
                return
        fi
	export LC_ALL=$OLD_LC_ALL
	for i in `ldd $1 | awk '{print $3}' | grep -v "^("`
	do
		i=`echo $i | sed 's@/lib64/@/lib/@g'`
		i=`echo $i | sed 's@/\.\./lib/@/@g'`
		P=`pm_whoprov $i`
		echo "pm_whoprov returns $P for $i"
		if [ "$P" = "$PKGNAME" ]
		then
			true
		elif [ "$P" != "" ]
		then
			depset_add $P
		fi
	done
}
export ABELFFLTRS="$ABELFFLTRS elfdep"
