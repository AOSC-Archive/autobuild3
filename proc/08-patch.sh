if [ ! -f .patch ]
then

# Not duplicate

if [ -f autobuild/patch ]
then
	. autobuild/patch
	touch .patch
elif [ -f autobuild/patches/series ]
then
	for i in `cat autobuild/patches/series`
	do
		patch -Np1 -i autobuild/patches/$i
	done
	touch .patch
elif [ -d autobuild/patches ]
then
	for i in autobuild/patches/*
	do
		patch -Np1 -i $i
	done
	touch .patch
fi


fi
