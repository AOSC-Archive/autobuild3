build_self_probe(){
	[ -f autobuild/build ]
}

build_self_build(){
	bash autobuild/build 
}

export ABBUILDS="$ABBUILDS self"
# Soga...