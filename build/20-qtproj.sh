abtryexe qmake || ablibret

build_qtproj_probe(){
	[ -f *.pro ] || return $?
	if bool $USEQT5; then
		QTPREFIX=/usr/lib/qt5
	elif bool $USEQT4; then
		QTPREFIX=/usr/lib/qt4
	else
		abicu "Qt version unspecified."
		QTPREFIX="$(dirname "$(dirname "$(which qmake)")")"
	fi
}

build_qtproj_build(){
	BUILD_START
	$QTPREFIX/bin/qmake
	BUILD_READY
	make $ABMK $MAKE_AFTER
	BUILD_FINAL
	make INSTALL_ROOT=$PKGDIR install
}
ABBUILDS+=' qtproj'
