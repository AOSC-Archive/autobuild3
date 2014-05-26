abrequire elf depset
elffltr_elfdep(){
	bool $ABELFDEP || return 0
	echo "Looking for Dependencies on $1 ..."
	for i in `ldd /bin/bash | awk '{print $3}' | grep -v "^("`
	do
		P=`pm_whoprov $i`
		if [ "$P" != "" ]
		then
			depset_add $P
		fi
	done
}
export ABELFFLTRS="$ABELFFLTRS elfdep"
