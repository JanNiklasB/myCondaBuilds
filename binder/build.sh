set -ex

if [ $OSTYPE == "darwin" ]; then
	export CC="$BUILD_PREFIX/bin/clang"
	export CXX="$BUILD_PREFIX/bin/clang++"
fi

# build binder:
cd $SRC_DIR/binder/
mkdir build && cd build
cmake .. -G Ninja
cmake --build . --target binder

mkdir -p $PREFIX/bin/
cp $(find $SRC_DIR/binder/ -name binder -type f) $PREFIX/bin/