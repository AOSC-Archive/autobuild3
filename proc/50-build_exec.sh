#!/bin/bash
##proc/build_do: So we build it now
##@copyright GPL-2.0+

if ! bool $ABSTAGE2; then
	arch_loadfile_strict prepare
else
	if arch_findfile prepare.stage2; then
		abwarn "ABSTAGE2 returned true, running stage2 prepare script ..."
		arch_loadfile_strict prepare.stage2
	elif arch_findfile prepare; then
		abwarn "ABSTAGE2 returned true, running stage2 prepare script ..."
		abwarn "Could not find stage2 prepare script, falling back to normal prepare script ..."
		arch_loadfile_strict prepare
	else
		true
	fi
fi

cd "$SRCDIR"

for build_func in build_{start,ready,final}; do
	abcmdstub "$build_func"
	alias "${build_func^^}=_ret=\$PIPESTATUS
	if ((_ret)); then
		bool \$ABSHADOW && cd ..
		return \$_ret
	fi
	echo $build_func | ablog
	$build_func || abwarn '$build_func: \$?'
	for _quirk in \$PKGQUIRKS; do
		if [[ \$_quirk == */* ]]; then
			[[ \$_quirk == ${build_func/#build_}/* ]] || continue
		else
			_quirk=${build_func/#build_}/\$_quirk
		fi
		if [ -e \"\$AB/quirks/\$_quirk\" ]; then
			. \"\$AB/quirks/\$_quirk\"
		fi
	done"
done

build_${ABTYPE}_build || abdie "Build failed: $?."

cd "$SRCDIR" || abdie "Unable to cd $SRCDIR: $?."

[ -d "$PKGDIR" ] || abdie "50-build: Suspecting build failure due to missing PKGDIR."

if ! bool $ABSTAGE2; then
	arch_loadfile_strict beyond
else
	if arch_findfile beyond.stage2; then
		abwarn "ABSTAGE2 returned true, running stage2 beyond script ..."
		arch_loadfile_strict beyond.stage2
	elif arch_findfile beyond; then
		abwarn "ABSTAGE2 returned true, running stage2 beyond script ..."
		abwarn "Could not find stage2 beyond script, falling back to normal beyond script ..."
		arch_loadfile_strict beyond
	else
		true
	fi
fi

if [ -d "$(arch_findfile overrides)" ] ; then
	abinfo "Deploying files in overrides ..."
	cp -arv "$(arch_findfile overrides)"/* "$PKGDIR/" || \
		abdie "Failed to deploy files in overrides: $?."
fi

cd "$SRCDIR" || abdie "Unable to cd $SRCDIR: $?."

unalias BUILD_{START,READY,FINAL}
