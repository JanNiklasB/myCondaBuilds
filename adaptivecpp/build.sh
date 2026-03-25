set -ex

# setting paths dependend on environment and situation
: "${SRC_DIR:=$(pwd)}"  # $() is function call, : is equal to true and in this context just ensures we do not get errors

# build adaptivecpp:
cd $SRC_DIR/adaptivecpp/
mkdir build && cd build
cmake .. -G Ninja \
	-DCMAKE_PREFIX_PATH=$PREFIX \
	-DCMAKE_BUILD_TYPE=Release \
	-DNVCXX_COMPILER=$PREFIX/bin/nvcc \
	-DACPP_SUBPROJECT_PARALLEL_JOBS=32 \
	-DOPENCL_INCLUDE_DIR=$PREFIX/include/CL \
	-DOPENCL_LIB_DIR=$PREFIX/lib \
	-DCMAKE_INSTALL_PREFIX=$PREFIX \
	-DLLVM_DIR=$CONDA_PREFIX/include/llvm \
	-DROCM_DEVICE_LIBS_PATH=$PREFIX/lib/amdgcn/bitcode/

cmake --build .
cmake --install .
