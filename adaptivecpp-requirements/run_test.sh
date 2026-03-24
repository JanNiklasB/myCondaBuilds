set -ex

cd AdaptiveCpp
mkdir build && cd build
cmake .. -G Ninja -DCMAKE_PREFIX_PATH=$TEST_PREFIX -DCMAKE_INSTALL_PREFIX=$TEST_PREFIX -DROCM_DEVICE_LIBS_PATH=$TEST_PREFIX/lib/amdgcn/bitcode/
cmake --build .
cmake --install .

cd ../../TestFiles
mkdir build && cd build
cmake .. -G Ninja -DCMAKE_PREFIX_PATH=$TEST_PREFIX -DCMAKE_INSTALL_PREFIX=$TEST_PREFIX
cmake --build .
./VectorAdd