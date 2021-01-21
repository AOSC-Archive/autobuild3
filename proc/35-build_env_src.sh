#!/bin/bash
##proc/build_env_src: Source build environment definition scripts.
##@copyright GPL-2.0+
for i in /etc/profile.d/*.sh; do
    abinfo "Sourcing environment definition script $i ..."
    source "$i" || abdie "Error sourcing environment definition: $i."
done
