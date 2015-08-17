# versionmeta: metadata
abtrylib pm || return
. /etc/lsb-release || return
: ${BUGURL:=https://bugs.anthonos.org}
AUTOTOOLS_DEF+=" --with-pkgversion=$(pm_dumpver)_${DISTRIB_ID// /_}' --with-bugurl=$BUGURL "
