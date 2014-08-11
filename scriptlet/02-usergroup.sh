user(){
	cat >> abscripts/usergroup << _ABEOF
	if grep ^$1: /etc/passwd >/dev/null
	then
		true
	else
		useradd -c "$5" -g $3 -d $4 -u $2 -s $6 $1 -m
	fi
_ABEOF
	N=$1
	shift 6
	for i
	do
		cat >> abscripts/usergroup << _ACEOF
		usermod -a -G $i $N
_ACEOF
	done
}
group(){
	cat >> abscripts/usergroup << _ABEOF
	if grep ^$1: /etc/group >/dev/null
	then
		true
	else
		groupadd -g $2 $1
	fi
_ABEOF
}
echo "#! /bin/bash" > abscripts/usergroup
chmod 755 abscripts/usergroup
if [ -e autobuild/usergroup ]
then
	. autobuild/usergroup
fi

unset user group
