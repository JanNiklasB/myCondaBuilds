#include <iostream>
#include <vector>
#include "SYCL/sycl.hpp"

using namespace std;

int main(){
	sycl::queue Q;
	cout << Q.get_device().get_info<sycl::info::device::name>() << endl;
	// generate data on host:
	size_t vecSize = 6;
	vector<double> TestVec1 = {0, 1, 2, 3, 4, 5};
	vector<double> TestVec2 = {1, 1, 1, 1, 1, 1};
	// reserve memory on device:
	auto DeviceVec1 = sycl::malloc_device<double>(vecSize, Q);
	auto DeviceVec2 = sycl::malloc_device<double>(vecSize, Q);
	// copy data to device:
	Q.memcpy(DeviceVec1, TestVec1.data(), vecSize*sizeof(double));
	Q.memcpy(DeviceVec2, TestVec2.data(), vecSize*sizeof(double));
	Q.wait();
	
	// do add operation:
	Q.submit([&](sycl::handler &h){
		h.parallel_for(sycl::range<1>(vecSize),
		[=](sycl::item<1> item){
			size_t idx = item.get_id(0);
			DeviceVec1[idx] += DeviceVec2[idx];
		});
	});
	Q.wait();
	// copy back data
	Q.memcpy(TestVec1.data(), DeviceVec1, vecSize*sizeof(double));
	Q.memcpy(TestVec2.data(), DeviceVec2, vecSize*sizeof(double));
	Q.wait();

	cout << "TestVec1 = ";
	for (auto entry : TestVec1)
		cout << entry << ", ";
	cout << endl << "TestVec2 = ";
	for (auto entry : TestVec2)
		cout << entry << ", ";
	cout << endl;

	return 0;
}