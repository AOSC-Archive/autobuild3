abrequire arch

if [ ! -f .patch ]
then
	if arch_loadfile patch
	then
		touch .patch
	elif [ -f autobuild/patches/series ]
	then
		for i in $(grep -v '#' autobuild/patches/series); do
			patch -Np1 -i autobuild/patches/$i
		done
		touch .patch
	elif [ -d autobuild/patches ]
	then
		for i in autobuild/patches/*.{patch,diff}; do
			patch -Np1 -i "$i"
		done
		touch .patch
	fi
fi
