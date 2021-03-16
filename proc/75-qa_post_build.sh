#!/bin/bash
##qa_post_build: Execute post-build QA modules.
##@copyright GPL-2.0+
bool $ABQA && \
for i in "$AB"/qa/post/*; do
	. "$i"
done

[[ -e "$SRCDIR"/abqawarn.log && ! -z "$SRCDIR"/abqawarn.log ]] && \
        abwarn "QA warning(s) found, please refer to abqawarn.log ..."
[[ -e "$SRCDIR"/abqaerr.log && ! -z "$SRCDIR"/abqaerr.log ]] && \
        abdie "QA error(s) found, please refer to abqaerr.log ..."
