abrequire qa
if qa_inset $PKGSEC section
then
	abinfo "QA PASS: PKGSEC"
else
	qa_die "PKGSEC ‘$PKGSEC’ INVALID"
fi
