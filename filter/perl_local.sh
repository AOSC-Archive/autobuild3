filter_perllocal(){
	abinfo "Removed perllocal.pod."
	rm -rf usr/lib/perl5/5.20.0/x86_64-linux-thread-multi/perllocal.pod
}

export ABFILTERS="$ABFILTERS perllocal"
