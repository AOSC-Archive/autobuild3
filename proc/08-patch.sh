if [ ! -f .patch ]
then

# Not duplicate
# I thought it can be useful to allow people run the patch file for multiple times, sometimes you just need to retest it...
# But there wasn't a way to prevent sed or whatever to run for more than one times and keeping the file the way it was supposed to.
#
# Never mind then.

if [ -f autobuild/patch ]
then
	. autobuild/patch
	touch .patch
elif [ -f autobuild/patches/series ]
then
	for i in `cat autobuild/patches/series`
	do
		patch -Np1 -i autobuild/patches/$i
		# Some patches are not -Np1 prefixed, keep in mind.
	done
	touch .patch
elif [ -d autobuild/patches ]
then
	for i in autobuild/patches/*.{patch,diff}
	# What if someone wants to comment some out? I am thinking that the old way is better somehow...
	do
		patch -Np1 -i $i
	done
	touch .patch
fi


fi
