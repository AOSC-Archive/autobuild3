abtrylib arch || ablibret

build_self_probe(){
	[ -f `arch_findfile build` ]
}

build_self_build(){
	BUILD_START
	arch_loadfile build
	cd $SRCDIR
}

ABBUILDS='self'
# Soga...
