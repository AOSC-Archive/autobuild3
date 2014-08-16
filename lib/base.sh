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

abloadlib(){
	if [ "$1" != "pm" ]
	then
	[ -f $AB/lib/$1.sh ] || return 1
	. $AB/lib/$1.sh
	else
	[ -f $AB/$ABMPM/lib/$1.sh ] || return 1
	. $AB/$ABMPM/lib/$1.sh
	fi
	export ABLIBS="${ABLIBS}$1|"
	echo "Loaded library $1"
}

abrequire(){
	for i; do
		echo $ABLIBS | grep "|$i|" > /dev/null || abloadlib $i || abdie "Library ‘$i’ not found."
	done
}

ablog(){
	if bool $ABDUMB
	then
		cat > ablog
	else
		tee ablog
	fi
}

returns() { return $*; }

abdie() {
  echo -e "\e[1;31mautobuild encountered an error and couldn't continue.\e[0m"
  echo -e "${1-Look at the stacktrace to see what happened.}"
  echo "--------------------------------------------------------------------------------"
  echo -e "Go to ‘\e[1mhttp://github.com/AOSC-Dev/autobuild3\e[0m’ for more information on this error."
  exit ${2-1}
}

# Should these information be redirected into ablog()?
abwarn(){
  echo -e "[\e[33mWARNING\e[0m]:\e[1m$*\e[0m" >&2
}

aberr(){
  echo -e "[\e[31mERROR\e[0m]:\e[1m$*\e[0m" >&2
}

abinfo(){
  echo -e "[\e[96mINFO\e[0m]:\e[1m$*\e[0m"
}

# Special Source, looks like stacktrace
.(){ source $* || (echo -e "  \e[31min $*\e[0m"; return 1); }
recsr(){ for sr in "$@"; do . $sr; done }