#!/bin/bash
##20-qtproj.sh: Builds qmake stuff
##@copyright GPL-2.0+
abtryexe qmake || ablibret
export QT_SELECT

build_qtproj_probe(){
	local _pros _pro
	_pros=("$SRCDIR"/*.pro)
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
	abinfo "Running qmake to generate Makefile ..."
	"$QTPREFIX/bin/qmake" $QTPROJ_DEF $QTPROJ_AFTER \
		|| abdie "Failed while running qmake to generate Makefile: $?."
	BUILD_READY
	abinfo "Building binaries ..."
	make V=1 VERBOSE=1 $ABMK $MAKE_AFTER \
		|| abdie "Failed to build binaries: $?."
	BUILD_FINAL
	abinfo "Installing binaries ..."
	make V=1 VERBOSE=1 INSTALL_ROOT=$PKGDIR install \
		|| abdie "Failed to install binaries: $?."
}

ABBUILDS+=' qtproj'
