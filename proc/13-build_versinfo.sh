#!/bin/bash
##proc/versionmeta: AOSC bugurl in version output
##@copyright GPL-2.0+

abtrylib pm || return 0
. /etc/lsb-release || return 0
: ${BUGURL:=https://bugs.anthonos.org}
AUTOTOOLS_DEF+=" --with-pkgversion=$(pm_dumpver)_${DISTRIB_ID// /_} --with-bugurl=$BUGURL "
true
