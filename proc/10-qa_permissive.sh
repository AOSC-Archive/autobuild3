#!/bin/bash
##10-qa_permissive.sh: Do not allow for permissive commands.
##@copyright GPL-2.0+
bool $ABQA || return
for permissive in 'rm -f' 'rm -rf' 'cp -f' 'cp -rf' 'mv -f'; do
	if grep -r "$permissive" "SRCDIR"/autobuild/{beyond,build,defines,patch,prepare}; then
	abicu "QA: $permissive may omit failed commands, please remove the -f flag!"
fi
