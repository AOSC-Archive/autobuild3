build_self_probe(){
	[ -f autobuild/build ]
}
build_self_build(){
	printf "\033[36m>>>\033[0m Running self-build scripts you just wrote..."
	sh autobuild/build
	if [ $? -ne 0 ]
	do
		printf "\033[31m[FAILED]\n\033[0m"
		printf "\033[33m-!- Error(s) occurred while running the script!\n\033[0m"
	else 
		printf "\033[32m[OK]\n\033[0m"
	fi
}
