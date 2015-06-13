. "$AB/arch/_common.sh"
. "$AB/arch/${CROSS:-$ARCH}.sh"
# The suffix get forked in multiple ways, basically FLAG_(COMPILER|COMMON)[_TYPE][_ISLTO].
for ABFLAG in {LD,C{XX,PP,}}FLAGS; do
	export $ABFLAG
	declare -n FLAG="$ABFLAG"
	for ABCC in COMMON $(bool $USECLANG && echo CLANG || echo GCC); do
		for ABTYPE in '' $AB_FLAGS_TYPES; do
			# unrolled: for ABFLTO in '' "_$(bool $NOLTO && echo -n NO; echo LTO)"
			declare -n THISFLAG="$ABFLAG_$ABCC_$ABTYPE"
			FLAG+="$THISFLAG"
			if bool $NOLTO; then
				declare -n THISFLAG="$ABFLAG_$ABCC_$ABTYPE_NOLTO"
			else
				declare -n THISFLAG="$ABFLAG_$ABCC_$ABTYPE_LTO"
			fi
			FLAG+="$THISFLAG"
		done
	done
	unset -n FLAG THISFLAG
	unset ABCC ABTYPE ABFLAG
done
