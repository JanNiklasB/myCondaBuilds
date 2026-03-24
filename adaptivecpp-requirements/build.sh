set -ex

# setting paths dependend on environment and situation
: "${SRC_DIR:=$(pwd)}"  # $() is function call, : is equal to true and in this context just ensures we do not get errors

cd $SRC_DIR
ls $SRC_DIR

# build llvm, lld and clang

# llvm:
cd $SRC_DIR/llvm-project/llvm/
mkdir build && cd build
cmake .. -G Ninja -DCMAKE_PREFIX_PATH=$PREFIX -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release
cmake --build .
cmake --install .
ln -s $PREFIX/lib/libLLVM-19.so $PREFIX/lib/libLLVM.so
# cp $PREFIX/lib/libLLVM-19.so $PREFIX/lib/libLLVM.so

# clang:
cd $SRC_DIR/llvm-project/clang/
mkdir build && cd build
cmake .. -G Ninja -DCMAKE_PREFIX_PATH=$PREFIX -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release -DLLVM_INCLUDE_TESTS=OFF
cmake --build .
cmake --install .

# lld:
cd $SRC_DIR/llvm-project/lld/
mkdir build && cd build
cmake .. -G Ninja -DCMAKE_PREFIX_PATH=$PREFIX -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release
cmake --build .
cmake --install .
