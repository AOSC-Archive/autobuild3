abreqexe python
build_python_probe(){
	[ -f setup.py ]	
}
build_python_build(){
printf "\033[36m>>>\033[0m Compiling Python project...			"
$PYTHON setup.py bdist &&
if [ $? -ne 0 ]
then
	printf "\033[31m[FAILED]\n\033[0m"
	printf "\033[33m-!- Error(s) occurred while compiling Python source!\033[0m"
else
	printf "\033[32m[OK]\n\033[0m"
fi
printf "\033[36m>>>\033[0m Installing Python project..."
cd dist &&
tar xvf *.tar.* &&
rm *.tar.* &&
cd .. &&
mv dist abdist
if [ $? -ne 0 ]
then
	printf "\033[31m[FAILED]\n\033[0m"
	printf "\033[33m-!- Error(s) occurred while installing Python project\n\033[0m"
else
	printf "\033[32m[OK]\n\033[0m"
fi
}
export ABBUILDS="$ABBUILDS python"
