#! /bin/bash
export ABSET=/etc/autobuild
export AB=$(cat $ABSET/prefix || echo $(dirname $(dirname $0)))
export ARCH=$(cat $ABSET/arch || uname -m || echo "x86_64")
[ $AB_DBG ] && set -xv
. $AB/lib/base.sh
. $AB/proc/*.sh