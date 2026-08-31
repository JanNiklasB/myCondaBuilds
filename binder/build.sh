set -ex

# build binder:
cd $SRC_DIR/binder/
python build.py -j $(nproc) --llvm-version 19.1.7

mkdir -p $PREFIX/bin/
cp $(find $SRC_DIR/binder/ -name binder -type f) $PREFIX/bin/