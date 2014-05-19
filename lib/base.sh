ABLIBS="|base|"

bool(){
	case $1 in
		0|f|F|false|n|N|no) return 1 ;;
		1|t|T|true|y|Y|yes) return 0 ;;
		*) return 1 ;;
	esac
}

abreqexe(){
	for i
	do
		if which $i > /dev/null
		then
			true
		else
			exit 1
		fi
	done
}

abloadlib(){
	[ -f $AB/lib/$1.sh ] || exit 1
	. $AB/lib/$1.sh
	export ABLIBS="${ABLIBS}$1|"
}

abrequire(){
	for i
	do
		if echo $ABLIBS | grep "|$1|" > /dev/null
		then
			true
		elif [ "$i" = "pm" ]
		then
			#special
			. $AB/$ABMPM/lib/pm.sh || exit 1
			export ABLIBS="${ABLIBS}pm|"
		else
			abloadlib $i || (echo No library $i ; exit 1)
		fi
	done
}
