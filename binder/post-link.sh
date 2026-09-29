if [ -f $PREFIX/bin/cmake ]; then
	cmake_root_dir=$($PREFIX/bin/cmake -G Ninja --system-information | grep CMAKE_ROOT -m 1 | sed -E 's/CMAKE_ROOT //g' | sed -E 's/\"//g')/Modules
	cp --recursive --target-directory "${cmake_root_dir}" $PREFIX/share/cppbinder/Modules/*
fi