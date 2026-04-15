set -ex

echo $PREFIX
find $PREFIX -type d -name xpointanalysis
# export CRPROPA_DATA_PATH=$PREFIX/share/crpropa
$PREFIX/bin/python -m xpointanalysis -o ./testoutput 100 1