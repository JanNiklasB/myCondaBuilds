set -ex

cd TestFiles
mkdir build && cd build
cmake .. -G Ninja
cmake --build .
./VectorAdd
ldd VectorAdd