#!/bin/bash
##11-qasec.sh: Kick the bucket if the section looks bad
##@copyright GPL-2.0+
abtrylib qa || return

if qa; then
	qa_inset "$PKGSEC" section && abinfo "QA PASS: PKGSEC"
else
	qa_die "PKGSEC ‘$PKGSEC’ INVALID"
fi

true
