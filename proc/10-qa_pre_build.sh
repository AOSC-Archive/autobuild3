#!/bin/bash
##qa_pre_build: Execute pre-build QA modules.
##@copyright GPL-2.0+
bool $ABQA && \
for i in "$AB"/qa/pre/*; do
	. "$i"
done

if [ -s "$SRCDIR"/abqawarn.log ]; then
	abwarn "QA warning(s) found, please refer to abqawarn.log ..."
fi

if [ -s "$SRCDIR"/abqaerr.log ]; then
	abdie "QA error(s) found, please refer to abqaerr.log ..."
fi
