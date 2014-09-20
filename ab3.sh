#! /bin/bash
export ABSET=/etc/autobuild
export AB=$(cat $ABSET/prefix 2>/dev/null || echo $(dirname $(dirname $0)))
export ARCH=$(cat $ABSET/arch 2>/dev/null || uname -m || echo "x86_64")
[ $AB_DBG ] && set -xv
[ $AB_SELF ] && AB=$(dirname $0)
. $AB/lib/base.sh
. $AB/proc/*.sh
