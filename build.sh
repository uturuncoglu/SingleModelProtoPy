rm -rf build
rm -f *.so
LDSHARED="ifort -shared" CC=icc FC=ifort python3 setup.py build_ext --inplace
