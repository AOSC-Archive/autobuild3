##AUTOBUILD TRIGGER SCRIPT HEADER
##@license CC0
# I'm a standalone script.
# (No) Not an autobuild lib!

# EXPORT FUNCTION trigger::interest
# interest <dir> [script:=postinst]
interest(){
	# $trset: if the package's trigger is written in this process.
	(( !trset )) && [ -d "abdist/$1" ] || return 0
	local scriptname="${2:-postinst}" pkgname="${0##*/}" # Naive but effective basename
	trset=1
	cat >> "abscripts/$scriptname" << EOF

#_aosc_ab trigger $pkgname:$scriptname
if [ -e /var/ab/triggered/$pkgname ]; then
    /var/ab/triggered/$pkgname || exit $?
fi
EOF
}
declare -fx interest # export function!
##END HEADER <trigger/lib.sh>
