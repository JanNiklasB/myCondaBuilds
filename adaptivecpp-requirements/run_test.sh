set -ex
echo $PREFIX

cd AdaptiveCpp
mkdir build && cd build
cmake .. -G Ninja -DCMAKE_PREFIX_PATH=$PREFIX -DCMAKE_INSTALL_PREFIX=$PREFIX -DROCM_DEVICE_LIBS_PATH=$PREFIX/lib/amdgcn/bitcode/
cmake --build .
cmake --install .

cd TestFiles
mkdir build && cd build
cmake .. -G Ninja -DCMAKE_PREFIX_PATH=$PREFIX -DCMAKE_INSTALL_PREFIX=$PREFIX
cmake --build .
./VectorAdd