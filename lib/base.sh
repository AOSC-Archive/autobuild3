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
		if which $i > /dev/null
		then
			true
		else
			exit 1
		fi
	done
}

abloadlib(){
	if [ "$1" != "pm" ]
	then
	[ -f $AB/lib/$1.sh ] || exit 1
	. $AB/lib/$1.sh
	else
	[ -f $AB/$ABMPM/lib/$1.sh ] || exit 1
	. $AB/$ABMPM/lib/$1.sh
	fi
	export ABLIBS="${ABLIBS}$1|"
	echo "Loaded library $1"
}

abrequire(){
	for i
	do
		if echo $ABLIBS | grep "|$i|" > /dev/null
		then
			true
		else
			abloadlib $i || (echo No library $i ; exit 1)
		fi
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

# Special Source, looks like stacktrace
.(){ source $* || (printf "  \e[31min $*\e[0m\n"; return 1); }
recsr(){ for sr in "$@"; do . $sr; done }
