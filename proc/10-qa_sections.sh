#!/bin/bash
##11-qasec.sh: Kick the bucket if the section looks bad
##@copyright GPL-2.0+
bool $ABQA || return
grep -qF "$PKGSEC" "$AB/sets/section" ||
	abicu "QA: $PKGSEC not in sets/section."
