#!/bin/bash
##20-qtproj.sh: Builds qmake stuffs
##@copyright GPL-2.0+
abtryexe qmake || ablibret
export QT_SELECT
build_qtproj_probe(){
	local _pros _pro
	_pros=(*.pro)
	((${#_pros[@]})) || return 1
	for _pro in "${_pros[@]}"; do
		[ -f "$_pro" ] && break
	done || return "$?"

	[ "$QT_SELECT" ] || 
	if bool $USEQT5; then
		abwarn "\$USEQT5 is now deprecated. Use QT_SELECT=5."
		QT_SELECT=5
	elif bool $USEQT4; then
		abwarn "\$USEQT4 is now deprecated. Use QT_SELECT=4."
		QT_SELECT=4
	else
		abicu "Qt version unspecified => default."
		QT_SELECT=default
	fi
}

build_qtproj_build(){
	BUILD_START
	"$QTPREFIX/bin/qmake" $QTPROJ_DEF $QTPROJ_AFTER
	BUILD_READY
	make $ABMK $MAKE_AFTER
	BUILD_FINAL
	make INSTALL_ROOT=$PKGDIR install
}
ABBUILDS+=' qtproj'
