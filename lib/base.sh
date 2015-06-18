#!/bin/bash
# Not to be run directly.
# TODO:	Add basic support for bashdb.
shopt -s expand_aliases extglob

declare -x ABLIBS="|base|" # GLOBAL: ABLIBS='|base[|lib1|lib2]|'

argprint(){ local p; for p; do printf %q\  "$p"; done; }
readonly true=1 false=0 yes=1 no=0

bool(){
	case "$1" in
		[0fFnN]|false|no) return 1 ;;
		[1tTyY]|true|yes) return 0 ;;
		*) return 2;;
	esac
}

abreqexe(){
	for i; do
		which $i &> /dev/null || abicu "Executable ‘$i’ not found; returned value: $?."{\ Expect\ failures.,}
	done
}
alias abtryexe='ABSTRICT=0 abreqexe'

abreqcmd(){
	for i; do
		(alias; declare -F) | /usr/bin/which -i --read-functions "$i" &> /dev/null ||
		abicu "Command ‘$i’ not found; returned value: $?."{\ Expect\ failures.,}
	done
}
alias abtrycmd='ABSTRICT=0 abreqcmd'
# So ugly...

abloadlib(){
	[ -f $ABBLPREFIX/$1.sh ] || return 127
	. $ABBLPREFIX/$1.sh || return $?
	ABLIBS+="$1|"
	abinfo "Loaded library $1" 1>&2
}

abrequire(){
	for i; do
		echo $ABLIBS | grep -q "|$i|" || abloadlib $i || abicu "Library ‘$i’ failed to load; returned value: $?."{\ Expect\ failures.,}
	done
}
alias abtrylib='ABSTRICT=0 abrequire'

ablog(){
	if bool $ABDUMB
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
	echo -e "\e[1;31mautobuild encountered an error and couldn't continue.\e[0m" 1>&2
	echo -e "${1-Look at the stacktrace to see what happened.}" 1>&2
	echo "------------------------------autobuild ${VERSION:-3}------------------------------" 1>&2
	echo -e "Go to ‘\e[1mhttp://github.com/AOSC-Dev/autobuild3\e[0m’ for more information on this error." 1>&2
	if ((AB_DBG)); then
		read -n 1 -p "AUTOBUILD_DEBUG: CONTINUE? (Y/N)" -t 5 AB_DBGRUN || AB_DBGRUN=false
		bool $AB_DBGRUN && abwarn "Forced AUTOBUILD_DIE continue." && return 0 || abdbg "AUTOBUILD_DIE EXIT - NO_CONTINUE"
	fi
	exit ${2-1}
}

# Should these information be redirected into ablog()?
# new ref impl: https://github.com/Arthur2e5/MobileConstructionVehicle/blob/master/common.sh
abwarn(){ echo -e "[\e[33mWARN\e[0m]: \e[1m$*\e[0m" >&2; }
aberr(){ echo -e "[\e[31mERROR\e[0m]: \e[1m$*\e[0m" >&2; }
abinfo(){ echo -e "[\e[96mINFO\e[0m]: \e[1m$*\e[0m" >&2; }
abdbg(){ echo -e "[\e[32mDEBUG\e[0m]:\e[1m$*\e[0m" >&2; }
ab_dbg(){ local _ret=$?; [ $AB_DBG ] && abdbg "$@"; return $_ret; }
recsr(){ for sr in "$@"; do . $sr; done }
argprint(){ local arg; for arg; do printf "%q " "$i"; done; }
# Special Source, looks like stacktrace
.(){
	ab_dbg "Sourcing from $1:"
	source "$@"
	local _ret=$? # CATCH_TRANSPARENT
	returns $_ret || abwarn ". $(argprint "$@") returned $_ret".
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
