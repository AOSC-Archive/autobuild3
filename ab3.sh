#!/bin/bash
# ab3.sh: the starting point
##@copyright GPL-2.0+

# Basic environment declarations
export VERSION=3
export ABSET=/etc/autobuild
if [ ! "$AB" ]; then
	export AB=$(cat "$ABSET/prefix" || dirname "$(readlink -e "$0")")
fi
export ABBLPREFIX=$AB/lib
export ABBUILD ABHOST ABTARGET
# compat 1.x and fallback
: "${ABBUILD=$ARCH}" "${ABHOST=${CROSS:-$ABBUILD}}" "${ABTARGET=$ABHOST}"

# For consistency of build output
export LANG=C.UTF-8

# Behavior
((AB_NOISY)) && set -xv
((AB_SELF)) && AB=$(dirname "$(readlink -e "$0")")

# Check and load base library
# TODO: split autobuild base libraries from the base libraries
#	or the other way around.
. $AB/lib/diag.sh || { echo "\e[1;91m FATAL: Cannot open stacktrace printing library! exiting."; exit 1; }
. $AB/lib/base.sh || { echo "\e[1;91m FATAL: Cannot open base library! exiting."; exit 1; }
. $AB/lib/builtins.sh || { echo "\e[1;91m FATAL: Cannot open utility function library! exiting."; exit 1; }

autobuild-help(){
	abinfo "Help Requested."
	echo -e "\e[1mAutobuild ${VERSION:-3}\e[0m, the next generation of autobuild for AOSC OS,\nwith multiple package manager support.\nAutobuild 3 is Licensed under the GNU General Public License, version 2.\n
  \e[1mBRIEF HELP:\tEnvironment variables\e[0m
  \e[1mAB_NOISY\e[0m\tRuns \`set -xv' if set to a non-empty value.
  \e[1mAB_SELF\e[0m\tBuilds autobuild itself in the source tree if set to a non-empty value.\n\t\tDefault if $ABSET/prefix doesn't exist.
  \e[1mAB_DBG\e[0m\tPrints debug information to stderr if set to a non-empty value.\n\t\tNow it prints the files sourced.\n"

	# Not implemented.
	# . $AB/extended-help 2>/dev/null

	abinfo "End of autobuild-core help."
	abinfo "See GitHub wiki at AOSC-Dev/autobuild3 for information on usage and hacking."
}

autobuild-clean(){
	rm -rf {abdist,*_*.tar.xz,*.deb,abscripts,abspec} && 
	abinfo "Build directory clean."
}
autobuild-plugin(){
	ab_dbg "Called plugin bootstrap.."
}

# Plugin and external command parser
if [ "$1" ]; then
	PATH="$AB/contrib:$PATH" PLUG="$1"
	shift
	ab_dbg "Starting autobuild-$PLUG"
	"autobuild-$PLUG" "$@"
	_ret=$?
	((!_ret)) || aberr "autobuild-$PLUG returned ${_ret}."
	exit $_ret
fi

# RTFM: help source
recsr $AB/proc/*.sh
