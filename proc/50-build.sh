[ -f autobuild/prepare ] && . autobuild/prepare
build_${ABTYPE}_build
_ret=$?
[ -d autobuild/overrides ] && cp -r autobuild/overrides/* abdist/
[ -f autobuild/beyond ] && . autobuild/beyond
returns $_ret