set -ex

# llvm:
cd $SRC_DIR/llvm-project/llvm/
mkdir build && cd build
cmake .. -G Ninja -DCMAKE_PREFIX_PATH=$PREFIX -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release
cmake --build .
cmake --install .
ln -s $PREFIX/lib/libLLVM-19.so $PREFIX/lib/libLLVM.so