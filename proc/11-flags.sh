. "$AB/arch/_common.sh"
. "$AB/arch/${CROSS:-$ARCH}.sh"
ABCC="$(basename "$CC")"
ABCC="${ABCC%%-*}"
ABCC="${ABCC^^}"
# The suffix get forked in multiple ways, basically FLAG_(COMPILER|COMMON)[_TYPE][_(NO)FEATURE].
AB_FLAGS_FEATURES_DEF="$(for f in $AB_FLAGS_FEATURES; do
		t="${f##NO_}" f="$t" def="${def%%$t}" v=1
		echo -n _
		declare -n u="USE$f" n="NO$f"
		if ((n)); then
			echo -n NO
		elif ((u)); then
			: # do nothing
		else 
			echo -n $def # default
		fi
		echo -n $f
	done
)"  # 'NOPONY NOCLA LTO GOTHIC' + ((USEPONY)) ((NOLTO)) -> '_PONY _NOCLA _NOLTO _GOTHIC'
for ABFLAG in {LD,C{,PP,XX}}FLAGS; do
	export $ABFLAG
	declare -n FLAG="$ABFLAG"
	for ABFLAGCC in COMMON $ABCC; do
		for ABFLAGTYPE in '' $AB_FLAGS_TYPES; do
			for ABFLAGFEATURE in '' $AB_FLAGS_FEATURES_DEF; do
				declare -n THISFLAG="${ABFLAG}_$ABFLAGCC$ABFLAGTYPE$ABFLAGFEATURE"
				FLAG+="$THISFLAG"
			done
		done
	done
	unset -n FLAG THISFLAG
	unset ABFLAG{,CC,TYPE,FEATURE}
done
CXXFLAGS="$CFLAGS $CXXFLAGS"
unset ABCC
