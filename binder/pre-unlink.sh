# !/bin/bash

cmake_root_dir=$($PREFIX/bin/cmake -G Ninja --system-information | grep CMAKE_ROOT -m 1 | sed -E 's/CMAKE_ROOT //g' | sed -E 's/\"//g')/Modules
rm -rf $cmake_root_dir/Findcppbinder.cmake $cmake_root_dir/cppbinder*