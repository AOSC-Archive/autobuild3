[ -f autobuild/prepare ] && . autobuild/prepare
build_${ABTYPE}_build || exit 1
[ -d autobuild/overrides ] && cp -r autobuild/overrides/* abdist/
[ -f autobuild/beyond ] && . autobuild/beyond
