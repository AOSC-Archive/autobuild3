abrequire arch

if [ ! -f .patch ]
then

	if [ -f `arch_filefind patch` ]
	then
		. `arch_filefind patch`
		touch .patch
	elif [ -f autobuild/patches/series ]
	then
		for i in `cat autobuild/patches/series`; do
			patch -Np1 -i autobuild/patches/$i
			# Some patches are not -Np1 prefixed, keep in mind.
		done
		touch .patch
	elif [ -d autobuild/patches ]
	then
		for i in autobuild/patches/*.{patch,diff}; do
			patch -Np1 -i $i
		done
		touch .patch
	fi

fi
