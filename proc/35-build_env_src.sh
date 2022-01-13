#!/bin/bash
##proc/build_env_src: Source build environment definition scripts.
##@copyright GPL-2.0+
for i in /etc/profile.d/*.sh; do
        abinfo "Sourcing environment definition script $i ..."
	# FIXME: A quirk for 30-nvm.sh, which mysteriously fails as Autobuild3 sources it.
	if [[ "$i" != "/etc/profile.d/30-nvm.sh" ]]; then
		source "$i" || abdie "Error sourcing environment definition: $i."
	else
		abwarn "FIXME: Ignoring errors for $i ..."
		source "$i" || true
	fi
done
