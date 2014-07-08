if [ "$ABTYPE" != "" ]
then
true
else
	for i in $ABBUILDS
	do
		# build are all plugins now.
		if build_${i}_probe
		then
			export ABTYPE=$i
			break
		fi
	done
fi
