#!/bin/bash
##sections.sh: Kick the bucket if the section looks bad
##@copyright GPL-2.0+
(test -z $PKGSEC && \
	aberr 'QA (E104): $PKGSEC not defined.') | \
		tee -a "$SRCDIR"/abqaerr.log

(grep -qF "$PKGSEC" "$AB/sets/section" || \
	aberr "QA (E104): $PKGSEC not in sets/section.") | \
		tee -a "$SRCDIR"/abqaerr.log
