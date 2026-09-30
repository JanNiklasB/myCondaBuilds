set -ex
# add $ADDPATH to $PATH
export PATH=$PATH:$ADDPATH

# build binder:
cd $SRC_DIR/binder/
mkdir build && cd build
cmake .. -G Ninja
cmake --build . --target binder

mkdir -p $PREFIX/bin/
cp $(find $SRC_DIR/binder/ -name binder -type f) $PREFIX/bin/

cmake_root_dir=$PREFIX/share/cppbinder/Modules
mkdir -p "${cmake_root_dir}"
cp --recursive --target-directory "${cmake_root_dir}" \
	$SRC_DIR/binder/cmake/cppbinder/ \
	$SRC_DIR/binder/cmake/cppbinder.cmake \
	$SRC_DIR/binder/cmake/Findcppbinder.cmake