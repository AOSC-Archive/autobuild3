abtrylib qa || return

if qa; then
	qa_inset "$PKGSEC" section && abinfo "QA PASS: PKGSEC"
else
	qa_die "PKGSEC ‘$PKGSEC’ INVALID"
fi

true
