alternative(){
	while [ "x$1" != "x" ]
	do
		echo "update-alternatives --install $1 `basename $1` $2 $3 " >> abscripts/postinst
		echo "update-alternatives --remove `basename $1` $2" >> abscripts/prerm
		shift
		shift
		shift
	done
}

if [ -e autobuild/alternatives ]
then
	. autobuild/alternatives
fi

unset alternative
