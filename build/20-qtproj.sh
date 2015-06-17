abreqexe qmake 
build_qtproj_probe(){
	[ -f *.pro ]
}
build_qtproj_build(){
	# ${qmake:-qmake} # changing to other qt prefixes
	if bool $USEQT5; then
		/usr/lib/qt5/bin/qmake &&
		make && make INSTALL_ROOT=$PKGDIR install
	elif bool $USEQT4; then
		/usr/lib/qt4/bin/qmake &&
		make && make INSTALL_ROOT=$PKGDIR install
	else
		abdie "Please specify a Qt version to use!"
	fi
}
export ABBUILDS="$ABBUILDS qtproj"
