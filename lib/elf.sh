abreqexe strip file
elf_iself()
{
	file $1 | grep '\: ELF' > /dev/null
}
elf_strip()
{
	elf_iself $1 || return 1
	strip --strip-debug $1
}
