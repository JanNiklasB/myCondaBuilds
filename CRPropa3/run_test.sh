set -ex

PYTHON_INCLUDE_DIR=$(${PYTHON} -c "import sysconfig; print(sysconfig.get_paths()['include'])")
NUMPY_INCLUDE_DIR=$(${PYTHON} -c "import numpy; print(numpy.get_include())")

rootFolder=$(pwd)

# build crpropa and copy test to own binary folder
cd crpropa
rm -rf build
mkdir build && cd build
cmake .. -G Ninja \
	-DCMAKE_PREFIX_PATH="${PREFIX}" \
	-DPython_EXECUTABLE="${PYTHON}" \
	-DPython_NumPy_INCLUDE_DIR="${NUMPY_INCLUDE_DIR}" \
	-DPython_INCLUDE_DIR="${PYTHON_INCLUDE_DIR}" \
	-DPython_INSTALL_PACKAGE_DIR="${SP_DIR}" \
	-DCMAKE_INSTALL_PREFIX="${PREFIX}" \
	-DBUILD_DOC=OFF \
	-DDOWNLOAD_DATA=ON \
	-DENABLE_COVERAGE=OFF \
	-DENABLE_GIT=ON \
	-DENABLE_HDF5=ON \
	-DENABLE_OPENMP=ON \
	-DENABLE_PYTHON=ON \
	-DENABLE_QUIMBY=ON \
	-DENABLE_SWIG_BUILTIN=ON \
	-DENABLE_TESTING=ON \
	-DFAST_WAVES=ON \
	-DINSTALL_EIGEN=OFF \
	-DOMP_SCHEDULE=dynamic \
	-DSIMD_EXTENSIONS=native \
	-DUSE_ABSOLUTE_RPATH=ON
cmake --build .
# now the build executable and binaries should point to the installed package rather the
# in the previous step build package.
mkdir $rootFolder/test/
for file in test*
do
	cp $file $rootFolder/test/
done
cp CTestTestfile.cmake $rootFolder/test/
cd $rootFolder/test/
rm -rf $rootFolder/crpropa
ctest