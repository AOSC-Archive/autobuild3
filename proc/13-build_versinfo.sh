#!/bin/bash
##proc/versionmeta: AOSC bugurl in version output
##@copyright GPL-2.0+

abtrylib pm || return 0
. /etc/os-release || return 0
: ${BUG_REPORT_URL:=https://github.com/AOSC-Dev/aosc-os-abbs/issues/}
AUTOTOOLS_DEF+=" --with-pkgversion=$(pm_dumpver)_${DISTRIB_ID// /_} --with-bugurl=$BUG_REPORT_URL "
true
