cd $PREFIX/adaptivecpp/
mkdir build && cd build
cmake .. -G Ninja \
	-DCMAKE_PREFIX_PATH=$PREFIX \
	-DCMAKE_BUILD_TYPE=Release \
	-DNVCXX_COMPILER=$PREFIX/bin/nvcc \
	-DACPP_SUBPROJECT_PARALLEL_JOBS=32 \
	-DOPENCL_INCLUDE_DIR=$PREFIX/include/CL \
	-DOPENCL_LIB_DIR=$PREFIX/lib \
	-DCMAKE_INSTALL_PREFIX=$PREFIX \
	-DROCM_DEVICE_LIBS_PATH=$PREFIX/lib/amdgcn/bitcode/
cmake --build .
cmake --install .