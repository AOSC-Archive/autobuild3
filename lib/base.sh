#!/bin/bash
##base.sh: Base library.
##@copyright GPL-2.0+ WITH GPL-Classpath-Exception
# Not to be run directly.
# TODO:	Add basic support for bashdb.
shopt -s expand_aliases extglob globstar nullglob

declare -x ABLIBS="|base|" # GLOBAL: ABLIBS='|base[|lib1|lib2]|'

argprint(){ printf '%q ' "$@"; }
readonly true=1 false=0 yes=1 no=0

bool(){
	case "$1" in
		[0fFnN]|false|no) return 1 ;;
		[1tTyY]|true|yes) return 0 ;;
		*) return 2;;
	esac
}

abreqexe(){
	local i;
	for i; do
		type $i &> /dev/null || abicu "Executable ‘$i’ not found; returned value: $?."{\ Expect\ failures.,}
	done
}

abtryexe(){
	local i;
	for i; do
		type $i &> /dev/null || abinfo "No executable ‘$i’ has been found; returned value: $?."
	done
}

_whichcmd(){ (alias; declare -f) | /usr/bin/which -i --read-functions "$1"; }
which --version 2>/dev/null | grep -q GNU || _whichcmd(){ alias "$1" || declare -f "$1" || which "$1"; }
abreqcmd(){
	local i;
	for i; do
		type "$i" &> /dev/null ||
		abicu "Command ‘$i’ not found; returned value: $?."{\ Expect\ failures.,}
	done
}

abtrycmd(){
	local i;
	for i; do
		type "$i" &> /dev/null ||
		abinfo "No command ‘$i’ has been found, returned value: $?."
	done
}

abcmdstub(){
	local i;
	for i; do
		_whichcmd "$i" &>/dev/null || alias "$i=${_ab_stub_body:-:}"
	done
}

abloadlib(){
	[ -f $ABBLPREFIX/$1.sh ] || return 127
	. "$ABBLPREFIX/$1.sh" || return
	ABLIBS+="$1|"
	abinfo "Loaded library $1" 1>&2
}

abrequire(){
	local i
	for i; do
		[[ $ABLIBS == *"|$i|"* ]] || abloadlib "$i" ||
		abicu "Library ‘$i’ failed to load; returned value: $?."{" Expect Failures",}
	done
}
alias abtrylib='ABSTRICT=0 abrequire'

ablog(){
	if bool "$ABDUMB"
	then cat > ablog
	else tee ablog
	fi
}

returns() { return $*; }
abcommaprint(){ local cnt; for i; do abmkcomma; echo -n "$i"; done; }
abmkcomma(){ ((cnt++)) && echo -n "${ABCOMMA-, }"; }

# hey buddy, you are dying!
abicu(){
	if ((ABSTRICT)); then
		[ "$2" ] && shift
		abdie "$@"
	else
		aberr "$1"
		return 1
	fi
}

abdie() {
	diag_print_backtrace
	echo -e "\e[1;31mautobuild encountered an error and couldn't continue.\e[0m" 1>&2
	echo -e "${1-Look at the stacktrace to see what happened.}" 1>&2
	echo "------------------------------autobuild ${ABVERSION:-3}------------------------------" 1>&2
	echo -e "Go to ‘\e[1mhttps://github.com/AOSC-Dev/autobuild3\e[0m’ for more information on this error." 1>&2
	if ((AB_DBG)); then
		read -n 1 -p "AUTOBUILD_DEBUG: CONTINUE? (Y/N)" -t 5 AB_DBGRUN || AB_DBGRUN=false
		bool $AB_DBGRUN && abwarn "Forced AUTOBUILD_DIE continue." && return 0 || abdbg "AUTOBUILD_DIE EXIT - NO_CONTINUE"
	fi
	exit "${2-1}"
}

# Should these information be redirected into ablog()?
# new ref impl: https://github.com/Arthur2e5/MobileConstructionVehicle/blob/master/common.sh
abwarn() { echo -e "[\e[33mWARN\e[0m]:  \e[1m$*\e[0m"; }
aberr()  { echo -e "[\e[31mERROR\e[0m]: \e[1m$*\e[0m"; }
abinfo() { echo -e "[\e[96mINFO\e[0m]:  \e[1m$*\e[0m"; }
abdbg()  { echo -e "[\e[32mDEBUG\e[0m]: \e[1m$*\e[0m"; }
ab_dbg() { local _ret=$?; [ $AB_DBG ] && abdbg "$@"; return $_ret; }
recsr(){ for sr in "$@"; do . $sr; done }
# Special Source, looks like stacktrace
.(){
	ab_dbg "Sourcing from $1:"
	source "$@"
	local _ret=$? # CATCH_TRANSPARENT
	returns $_ret || abwarn ". $(argprint "$@")returned $_ret".
	ab_dbg "End Of $1."
	return $_ret
}

# aosc_lib LIBNAME
aosc_lib(){
	if [ "$(basename "$0")" == "$1.sh" ]; then
		abdie "$1 is a library and shouldn't be executed directly." 42
	fi
}

aosc_lib base

aosc_lib_skip(){
	abwarn "${1-$AOSC_SOURCE} loading skipped."
	return 1
}
alias ablibret='aosc_lib_skip $BASH_SOURCE || return 0'

# shopt/set control
# Name-encoding: Regular shopts should just use their regular names,
# and setflags use '-o xxx' as the name.
declare -A opt_memory
# set_opt opt-to-set
set_opt(){
	[ "$1" ] || return 2
	if ! shopt -q $1; then
		shopt -s $1 && # natural validation
		opt_memory["$1"]=0
	fi
}
# rec_opt [opts-to-recover ...]
rec_opt(){
	local _opt
	if [ -z "$1" ]; then
		rec_opt "${!opt_memory[@]}"
	elif [ "$1" == '-o' ]; then
		rec_opt "${!opt_memory[@]/#!(-o*)/_skip}"
	elif [ "$1" == '+o' ]; then
		rec_opt "${!opt_memory[@]/#-o*/_skip}"
	else
		for _opt; do
			[ "$_opt" == _skip ] && continue
			case "${opt_memory[$_opt]}" in
				(0)	uns_opt "$_opt";;
				(1)	set_opt "$_opt";;
				(*)	abwarn "Invaild memory $_opt: '${opt_memory[$_opt]}'"; unset opt_memory["$_opt"];;
			esac
		done
	fi
}
# uns_opt opt-to-unset
uns_opt(){
	[ "$1" ] || return 2
	if shopt -q $1; then
		shopt -s $1 && # natural validation
		opt_memory["$1"]=1
	fi
}

# USEOPT/NOOPT control
boolopt(){
	local t="$1"
	declare -n n u
	t="${f##NO_}"
	u="USE$t" n="NO$t"
	if ((n)); then
		return 1
	elif ((u)); then
		return 0
	elif [[ "$t" == NO_* ]]; then
		return 1
	else
		return 0
	fi
}

# <SOMETHING>_AFTER type checking
# returns 0 if $1 points to an array
abisarray() {
	local VARIABLE_NAME="$1"
	local VARIABLE_DECL=$( (declare -p $VARIABLE_NAME 2>/dev/null ) | head -1 | cut -f 2 -d ' ' )

	if [[ "${VARIABLE_DECL}" == -*a* ]]; then
		return 0
	else
		return 1
	fi
}

# $1 = NAME of variable to check
# return 0 if $1 points to a defined variable regardless of type
abisdefined() {
	local VARIABLE_NAME="$1"
	declare -p $VARIABLE_NAME 2>/dev/null 
}

# $1 = NAME of source variable, single string or array
# $2 = NAME of destination variable of the same type
# This function will aberr if type doesn't match
abcopyvar() {
	local src=$1
	local dst=$2

	# Type checking
	abisarray $src
	local -i src_is_array=$?
	abisarray $dst
	local -i dst_is_array=$?

	if [[ $src_is_array -ne $dst_is_array ]]; then
		if [[ $src_is_array -eq 0 ]]; then
			aberr "$src is an array, but $dst is a single string."
		else
			aberr "$src is a single string, but $dst is an array."
		fi
		abdie "Refusing to copy variables of different type!"
	fi

	# Create references for content r/w
	local -n ref_read_src=$src
	local -n ref_write_dst=$dst

	if [[ $src_is_array -eq 0 ]]; then
		ref_write_dst=("${ref_read_src[@]}")
	else
		ref_write_dst="${ref_read_src}"
	fi
}
