#!/bin/bash
##qa_post_build: Execute post-build QA modules.
##@copyright GPL-2.0+
bool $ABQA && \
for i in "$AB"/qa/post/*; do
	arch_loadfile_strict "$i"
done

[ -e "$SRCDIR"/qawarn.log ] && \
        abwarn "QA warning(s) found, log printed below ..."
[ -e "$SRCDIR"/qaerr.log ] && \
	abdie "QA error(s) found, log printed below ..."
