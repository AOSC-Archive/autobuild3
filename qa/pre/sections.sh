#!/bin/bash
##sections.sh: Kick the bucket if the section looks bad
##@copyright GPL-2.0+
if echo "$PKGSEC" | grep -q '/'; then
	QASEC="$(echo $PKGSEC | cut -d / -f 2-)"
else
	QASEC="$PKGSEC"
fi

grep -qF "$QASEC" "$AB/sets/section" ||
	abdie "QA (E104): $QASEC not in sets/section."
