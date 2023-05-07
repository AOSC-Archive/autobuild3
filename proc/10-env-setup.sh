#!/bin/bash
##10-env-setup: Setting up common environmental variables
##@copyright GPL-2.0+

abinfo 'Setting $SHELL to /bin/bash ...'
export SHELL="/bin/bash"

abinfo 'Setting $HOME to /root ...'
export HOME="/root"

if [ -e /usr/lib/hook_uname.so ]; then
    abinfo 'hook_uname.so detected, preloading ...'
    export LD_PRELOAD="/usr/lib/hook_uname.so:$LD_PRELOAD"
fi
