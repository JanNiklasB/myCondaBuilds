set -ex

cd TestFiles
mkdir build && cd build
cmake .. -G Ninja -DCMAKE_PREFIX_PATH=$TEST_PREFIX
cmake --build .
./VectorAdd
ldd VectorAdd