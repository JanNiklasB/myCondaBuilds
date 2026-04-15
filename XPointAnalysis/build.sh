set -ex

PYTHON_INCLUDE_DIR=$(${PYTHON} -c "import sysconfig; print(sysconfig.get_paths()['include'])")
NUMPY_INCLUDE_DIR=$(${PYTHON} -c "import numpy; print(numpy.get_include())")

cd $SRC_DIR/xpointanalysis
mkdir build && cd build
cmake .. -G Ninja \
	-DENABLE_PYTHON=ON \
	-DCMAKE_INSTALL_PREFIX=$PREFIX \
	-DCMAKE_PREFIX_PATH=$PREFIX \
	-DPython_EXECUTABLE=$PYTHON \
	-DPython_NumPy_INCLUDE_DIR=$NUMPY_INCLUDE_DIR \
	-DPython_INCLUDE_DIR=$PYTHON_INCLUDE_DIR
cmake --build .
cmake --install .
$PREFIX/bin/pybind11-stubgen -o ${SP_DIR} xpointfield 


cd $SRC_DIR/xpointanalysis/Analysis
mkdir build && cd build
cmake .. -G Ninja \
	-DCMAKE_INSTALL_PREFIX=$PREFIX \
	-DCMAKE_PREFIX_PATH=$PREFIX \
	-DPython_EXECUTABLE=$PYTHON \
	-DPython_NumPy_INCLUDE_DIR=$NUMPY_INCLUDE_DIR \
	-DPython_INCLUDE_DIR=$PYTHON_INCLUDE_DIR \
	-DCRPROPA_PATH=$PREFIX \
	-DXPOINTFIELD_PATH=$PREFIX
cmake --build .
cmake --install .
$PREFIX/bin/pybind11-stubgen -o ${SP_DIR} xpointanalysis

# Copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d.
# This will allow them to be run on environment activation.
for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done
