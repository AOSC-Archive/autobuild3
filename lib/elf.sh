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
	printf "\033[36m>>>\033[0m Stripping ELF files/archives...	 	\033[0m"
	strip --strip-debug $1 2> /dev/null
	printf "\033[32m[OK]\n\033[0m"
}

