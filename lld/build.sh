set -ex

# lld:
cd $SRC_DIR/llvm-project/lld/
mkdir build && cd build
cmake .. -G Ninja -DCMAKE_PREFIX_PATH=$PREFIX -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release
cmake --build .
cmake --install .