alternative(){
	while [ "x$1" != "x" ]
	do
		printf "\033[36m>>>\033[0m Updating alternatives for packages..."
		echo "update-alternatives --install $1 `basename $1` $2 $3 " >> abscripts/postinst
		echo "update-alternatives --remove `basename $1` $2" >> abscripts/prerm
		shift
		shift
		shift
		printf "\033[32m[OK]\n\033[0m"
	done
}

if [ -e autobuild/alternatives ]
then
	. autobuild/alternatives
fi

unset alternatives
