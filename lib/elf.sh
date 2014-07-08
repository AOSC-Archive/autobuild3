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
	strip --strip-debug $1 
}

