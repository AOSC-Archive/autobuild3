#!/bin/bash
##proc/flags: makes *FLAGS from arch/
##@copyright GPL-2.0+

ABCC="$(basename "$CC")"
ABCC="${ABCC%%-*}"
ABCC="${ABCC^^}"
BUILD=${ARCH_TARGET["$ABBUILD"]}
HOST=${ARCH_TARGET["$ABHOST"]}

. "$AB/arch/_common_switches.sh"

if [[ $ABBUILD != $ABHOST ]]; then
	AB_FLAGS_TYPES+="_CROSS _CROSS_$ABBUILD "
fi

# The suffix get forked in multiple ways, basically FLAG_(COMPILER|COMMON)[_TYPE][_(NO)FEATURE].
AB_FLAGS_FEATURES_DEF="$(
	for f in $AB_FLAGS_FEATURES; do
		t="${f##NO_}" f="$t" def="${def%%$t}" v=1
		echo -n _
		u="USE$f" n="NO$f"
		if ((n)); then
			echo -n NO
		elif ((u)); then
			: # do nothing
		else 
			echo -n $def # default
		fi
		echo -n "$f "
	done
)"  # 'NOPONY NOCLA LTO GOTHIC' + ((USEPONY)) ((NOLTO)) -> '_PONY _NOCLA _NOLTO _GOTHIC'
_flags_weird_buf=()
_flags_current_i=0
for ABFLAG in {LD,C{,PP,XX},OBJC{,XX}}FLAGS; do
	export $ABFLAG
	declare -n FLAG="$ABFLAG"
	for ABFLAGCC in COMMON $ABCC; do
		for ABFLAGTYPE in '' $AB_FLAGS_TYPES; do
			for ABFLAGFEATURE in '' $AB_FLAGS_FEATURES_DEF; do
				THISFLAG="${ABFLAG}_$ABFLAGCC$ABFLAGTYPE$ABFLAGFEATURE"
				if [[ "$ABFLAGTYPE" == _WEIRD ]]; then
					_flags_weird_buf[_flags_current_i]+=" ${!THISFLAG}"
				else
					FLAG+=" ${!THISFLAG}"
				fi
			done
		done
	done
	unset -n FLAG THISFLAG
	unset ABFLAG{,CC,TYPE,FEATURE}
	((_flags_current_i++))
done
_flags_current_i=0
CXXFLAGS="$CFLAGS $CXXFLAGS"
OBJCFLAGS="$CFLAGS $OBJCFLAGS"
OBJCXXFLAGS="$OBJCFLAGS $CXXFLAGS"
for ABFLAG in {LD,C{,PP,XX},OBJC{,XX}}FLAGS; do
	declare -n FLAG="$ABFLAG";
	FLAG+="${_flags_weird_buf[_flags_current_i]}"; ((_flags_current_i++));
	unset -n FLAG;
done
unset ABCC _flags_current_i
