#!/bin/bash
##proc/versionmeta: AOSC bugurl in version output
##@license GPL-2.0+

abtrylib pm || return
. /etc/lsb-release || return
: ${BUGURL:=https://bugs.anthonos.org}
AUTOTOOLS_DEF+=" --with-pkgversion=$(pm_dumpver)_${DISTRIB_ID// /_} --with-bugurl=$BUGURL "
