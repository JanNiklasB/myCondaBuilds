#!/bin/bash

cmake_root_dir=$($PREFIX/bin/cmake -G Ninja --system-information | grep CMAKE_ROOT -m 1 | sed -E 's/CMAKE_ROOT //g' | sed -E 's/\"//g')/Modules

OS=$(uname)
if [ $OS = "Linux" ]; then
	cp --recursive --target-directory "${cmake_root_dir}" $PREFIX/share/cppbinder/Modules/*
elif [ $OS = "Darwin" ]; then
	cp -R $PREFIX/share/cppbinder/Modules/* "${cmake_root_dir}"
fi