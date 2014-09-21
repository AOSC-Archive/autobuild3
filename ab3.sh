#! /bin/bash
export VERSION=3
export ABSET=/etc/autobuild
export AB=$(cat $ABSET/prefix 2>/dev/null || echo $(dirname $(dirname $0)))
export ARCH=$(cat $ABSET/arch 2>/dev/null || uname -m || echo "x86_64")
[ $AB_NOISY ] && set -xv
[ $AB_SELF ] && AB=$(dirname $0)
. $AB/lib/base.sh
[[ "$1" =~ help ]] && {
abinfo "Help Requested."
echo -e "\e[1mAutobuild ${VERSION:-3}\e[0m, the next generation of autobuild for AOSC OS3,\nwith multiple package manager support.\nAutobuild 3 is Licensed under the GNU General Public License, version 2.\n
\e[1mBRIEF HELP: Environment variables\e[0m
  \e[1mAB_NOISY\e[0m Runs \`set -xv' if set to a non-empty value.
  \e[1mAB_SELF\e[0m Builds autobuild itself in the source tree if set to a non-empty value.
  \e[1mAB_DBG\e[0m Prints debug information to stderr if set to a non-empty value.\n\tNow it prints the files sourced."
abinfo "End of autobuild-core help. See GitHub wiki at AOSC-Dev/autobuild3 for information on usage and hacking."; exit 0; }
# RTFM: help source
recsr $AB/proc/*.sh
