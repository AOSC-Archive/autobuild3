abrequire qa
if qa; then qa_inset "$PKGSEC" section && abinfo "QA PASS: PKGSEC" || qa_die "PKGSEC ‘$PKGSEC’ INVALID"; fi
true
