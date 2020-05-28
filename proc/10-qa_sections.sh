#!/bin/bash
##10-qa_sections.sh: Kick the bucket if the section looks bad
##@copyright GPL-2.0+
bool "$ABQA" || return
if echo "$PKGSEC" | grep -q '/'; then
	QASEC="$(echo "$PKGSEC" | cut -d / -f 2-)"
else
	QASEC="$PKGSEC"
fi
grep -qF "$QASEC" "$AB/sets/section" ||
	abdie "QA: $QASEC not in sets/section."
