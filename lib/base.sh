ABLIBS="|base|"

bool(){
  case $1 in
		0|f|F|false|n|N|no) return 1 ;;
		1|t|T|true|y|Y|yes) return 0 ;;
		*) return 1 ;;
	esac
}

abreqexe(){
	for i; do
	  which $i > /dev/null || abdie "Executable ‘$i’ not found."
	done
}

# So ugly...

abloadpm(){
        . $AB/$ABMPM/lib/pm.sh
	export ABLIBS="${ABLIBS}pm|"	
	echo "Loaded library pm" 1>&2
}

abloadlib(){
	if [ "x$1" = "xpm" ] 
	then
		abloadpm
		return
	fi
	[ -f $ABBLPREFIX/$1.sh ] || return 1
	. $ABBLPREFIX/$1.sh
	export ABLIBS="${ABLIBS}$1|"
	echo "Loaded library $1" 1>&2
}

abrequire(){
	for i; do
		echo $ABLIBS | grep "|$i|" > /dev/null || abloadlib $i || abdie "Library ‘$i’ not found."
	done
}

ablog(){
	if bool $ABDUMB
	then cat > ablog
	else tee ablog
	fi
}

returns() { return $*; }

abcommaprint(){ 
  local FIRST=true
  for i; do
		if $FIRST; then FIRST=false
		else printf " , "; fi
	  printf $i
	done
}

abdie() {
  echo -e "\e[1;31mautobuild encountered an error and couldn't continue.\e[0m"
  echo -e "${1-Look at the stacktrace to see what happened.}"
  echo "------------------------------autobuild ${VERSION:-3}------------------------------"
  echo -e "Go to ‘\e[1mhttp://github.com/AOSC-Dev/autobuild3\e[0m’ for more information on this error."
  if [ $AB_DBG ]; then read -p "AUTOBUILD_DEBUG: CONTINUE? (Y/N)" -t 5 AB_DBGRUN || AB_DBGRUN=false
  bool $AB_DBGRUN && abwarn "Forced AUTOBUILD_DIE continue." && return 0 || abdbg "AUTOBUILD_DIE EXIT - NO_CONTINUE/CONTINUE_TIMEDOUT"
  fi
  exit ${2-1}
}

# Should these information be redirected into ablog()?
abwarn(){ echo -e "[\e[33mWARN\e[0m]: \e[1m$*\e[0m" >&2; }
aberr(){ echo -e "[\e[31mERROR\e[0m]: \e[1m$*\e[0m" >&2; }
abinfo(){ echo -e "[\e[96mINFO\e[0m]: \e[1m$*\e[0m" >&2; }
abdbg(){ echo -e "[\e[32mDEBUG\e[0m]:\e[1m$*\e[0m" >&2; }
ab_dbg(){ local _ret=$?; [ $AB_DBG ] && abdbg "$@"; return $_ret; }
# Special Source, looks like stacktrace
.(){ ab_dbg "Source Code from $1:"; source $* || (echo -e "  \e[31min $*\e[0m"; return 1); ab_dbg "---------------"; }
recsr(){ for sr in "$@"; do . $sr; done }
