set -ex

# clang:
cd $SRC_DIR/llvm-project/clang/
mkdir build && cd build
cmake .. -G Ninja -DCMAKE_PREFIX_PATH=$PREFIX -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release -DLLVM_INCLUDE_TESTS=OFF
cmake --build .
cmake --install .