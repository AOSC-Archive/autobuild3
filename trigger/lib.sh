# I'm a stand-along script.
# (No) Not an autobuild lib!

interest(){
	if [ -d abdist/$1 ]
	then
		if [ "$trset" != "1" ]
		then
			trset=1
			echo "if [ -e /var/ab/triggered/$PKGNAME ]" >> abscripts/postinst
			echo "then" >> abscripts/postinst
			echo "/var/ab/triggered/$PKGNAME || exit 1" >> abscripts/postinst
			echo "fi" >> abscripts/postinst
		fi
	fi
}



