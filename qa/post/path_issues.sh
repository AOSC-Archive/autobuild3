#!/bin/bash
##path_issues: Check for incorrectly installed paths.
##@copyright GPL-2.0+

for i in \
	bin sbin lib lib64 run usr/sbin usr/lib64 \
	usr/local usr/man usr/doc usr/etc usr/var; do
	if [ -e "$PKGDIR"/${i} ]; then
		aberr "QA (E321): Found known bad path in package:\n    $i" | \
			tee -a "$SRCDIR"/abqaerr.log
	fi
done

ACCEPTABLE="
"$PKGDIR"/boot
"$PKGDIR"/dev
"$PKGDIR"/efi
"$PKGDIR"/etc
"$PKGDIR"/home
"$PKGDIR"/media
"$PKGDIR"/mnt
"$PKGDIR"/opt
"$PKGDIR"/proc
"$PKGDIR"/root
"$PKGDIR"/run
"$PKGDIR"/srv
"$PKGDIR"/sys
"$PKGDIR"/tmp
"$PKGDIR"/usr
"$PKGDIR"/usr/bin
"$PKGDIR"/usr/include
"$PKGDIR"/usr/lib
"$PKGDIR"/usr/libexec
"$PKGDIR"/usr/local
"$PKGDIR"/usr/local/bin
"$PKGDIR"/usr/local/include
"$PKGDIR"/usr/local/lib
"$PKGDIR"/usr/local/libexec
"$PKGDIR"/usr/local/share
"$PKGDIR"/usr/local/src
"$PKGDIR"/usr/share
"$PKGDIR"/usr/src
"$PKGDIR"/var
"
PATHS="$(find "$PKGDIR" -maxdepth 2 -type d -print)"
for i in $PATHS; do
	if ! echo $ACCEPTABLE | grep -q $i; then
		aberr "QA (E321): found unexpected path(s) in package:\n    $i"
	fi
done

for i in "$PKGDIR"/{dev,home,proc,sys,tmp}; do
	if [ -e $i ]; then
		abwarn "QA (E321): found pseudo filesystem, template, or temporary directory(s) in package (building aosc-aaa?):\n    $i"
	fi
done
