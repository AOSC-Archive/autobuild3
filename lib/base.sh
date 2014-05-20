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
		printf "\033[36m>>>\033[0m Checking system environment and necessary programs...		"
		if which $i > /dev/null
		then
			printf "\033[32m[OK]\033[0m"
			true
		else
			printf "\033[31m[FAILED]\n\033[0m"
			printf "\033[33m-!- Some necessary programs are not found or not in PATH\033[0m"
			# Needed program which are not here shall be listed below...
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
			# Special
			# Special what... /etc/autobuild.d/10-pm or whatever to decide the PM used?
			. $AB/$ABMPM/lib/pm.sh || exit 1
			export ABLIBS="${ABLIBS}pm|"
		else
			abloadlib $i || (echo No library $i ; exit 1)
		fi
	done
}
