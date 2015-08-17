# a more precise one
# addalt link name path prio
addalt(){
	echo "update-alternatives --install $(argprint "$@")" >> $PKGDIR/postinst
	echo "update-alternatives --remove $(argprint "$2" "$3")" >> $PKGDIR/prerm
}

# alternative path link prio [path2 link2 prio2 ..]
alternative(){ while [ "$1" ]; do addalt "$1" "$(basename "$1")" "$2" "$3"; shift 3 || break; done; }

if [ -e autobuild/alternatives ]
then
	echo "# alternatives" >> $PKGDIR/postinst
	echo "# alternatives" >> $PKGDIR/prerm
	. autobuild/alternatives
fi

unset alternative addalt
