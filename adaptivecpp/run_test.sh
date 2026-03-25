set -ex

cd TestFiles
mkdir build && cd build
cmake .. -G Ninja -DCMAKE_PREFIX_PATH=$PREFIX
cmake --build .
./VectorAdd