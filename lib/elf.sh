abreqexe strip file

elf_iself()
{
	file $1 | grep '\: ELF' > /dev/null
}

elf_strip()
{
	elf_iself $1 || return 1
	# If a library can only be stripped with its debug symbols... 
	# Just trying to think of a way to seperate those files, like in /{bin,usr/bin,sbin,usr,sbin} or /{lib,usr/lib}
	if ( echo "$i" | grep "/bin/" 1>/dev/null 2>&1 || echo "$i" | grep "/sbin" 1>/dev/null 2>&1 )
	# Dirty, but it works. Never change this to grep "bin/", since something like cgi-bin/ always exists.
	then strip --strip-all $1 2> /dev/null
	else strip --strip-debug $1 2> /dev/null
	fi
	# https://bugs.archlinux.org/task/13592
}

