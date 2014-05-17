abreqexe strip file
elf_iself()
{
	file $1 | grep '\: ELF' > /dev/null
}
