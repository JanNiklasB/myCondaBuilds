set -ex

# setting paths dependend on environment and situation
: "${SRC_DIR:=$(pwd)}"  # $() is function call, : is equal to true and in this context just ensures we do not get errors

# build adaptivecpp:
cd $SRC_DIR/adaptivecpp/
mkdir build && cd build
cmake .. -G Ninja -DCMAKE_PREFIX_PATH=$PREFIX -DCMAKE_INSTALL_PREFIX=$PREFIX -DROCM_DEVICE_LIBS_PATH=$PREFIX/lib/amdgcn/bitcode/
cmake --build .
cmake --install .
