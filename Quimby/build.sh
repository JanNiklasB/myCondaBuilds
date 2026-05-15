set -ex

PYTHON_INCLUDE_DIR=$(${PYTHON} -c "import sysconfig; print(sysconfig.get_paths()['include'])")
NUMPY_INCLUDE_DIR=$(${PYTHON} -c "import numpy; print(numpy.get_include())")

cd $SRC_DIR/quimby
mkdir build && cd build
cmake .. -G Ninja \
	-DCMAKE_PREFIX_PATH="${PREFIX}" \
	-DPython_EXECUTABLE="${PYTHON}" \
	-DPython_NumPy_INCLUDE_DIR="${NUMPY_INCLUDE_DIR}" \
	-DPython_INCLUDE_DIR="${PYTHON_INCLUDE_DIR}" \
	-DPython_INSTALL_PACKAGE_DIR="${SP_DIR}" \
	-DCMAKE_INSTALL_PREFIX="${PREFIX}" \
	-DENABLE_OPENMP=ON \
	-DENABLE_SWIG_BUILTIN=ON \
	-DQUIMBY_ENABLE_PYTHON=ON \
	-DQUIMBY_ENABLE_ROOT=OFF \
	-DQUIMBY_ENABLE_TESTING=OFF
cmake --build .
cmake --install .
$PREFIX/bin/pybind11-stubgen -o ${SP_DIR} quimby