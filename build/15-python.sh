abreqexe python
build_python_probe(){
	[ -f setup.py ]
}
build_python_build(){
$PYTHON setup.py bdist &&
cd dist &&
tar xvf *.tar.* &&
rm *.tar.* &&
cd .. &&
mv dist abdist
}
export ABBUILDS="$ABBUILDS python"
