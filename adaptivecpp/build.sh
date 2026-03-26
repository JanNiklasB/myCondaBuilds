set -ex

# copy adaptivecpp to prefix folder
cp -r $SRC_DIR/adaptivecpp/ $PREFIX/adaptivecpp/
if [ -e $PREFIX/lib/clang/21/lib/x86_64-unknown-linux-gnu/ ]; then
	mv $PREFIX/lib/clang/21/lib/x86_64-unknown-linux-gnu/ $PREFIX/lib/clang/21/lib/x86_64-conda-linux-gnu/
fi

# build adaptivecpp:
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
