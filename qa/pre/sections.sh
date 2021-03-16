#!/bin/bash
##sections.sh: Kick the bucket if the section looks bad
##@copyright GPL-2.0+
(grep -qF "$PKGSEC" "$AB/sets/section" || aberr "QA (E104): $PKGSEC not in sets/section.") | \
	tee -a "$SRCDIR"/abqaerr.log
