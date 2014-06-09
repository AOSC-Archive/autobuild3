abrequire qa
if qa_inset $PKGSEC section
then
	echo "QA PASS: PKGSEC"
else
	qa_die "PKGSEC"
fi

