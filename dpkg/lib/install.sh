printf "\033[36m>>>\033[0m Installing package...		"
dpkg -i $PKGNAME.deb
if [ $? -ne 0 ]
then
	printf "\033[31m[FAILED]\n\033[0m"
else
	printf "\033[32m[OK]\n\033[0m"
fi
