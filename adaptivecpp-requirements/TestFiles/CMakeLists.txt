cmake_minimum_required(VERSION 3.25.1)

project(acpptest VERSION 1.0.0)
set(CMAKE_CXX_STANDARD 23)
add_definitions(-w)

# set(ACPP_TARGETS )
find_package(AdaptiveCpp REQUIRED)

add_executable(VectorAdd ${CMAKE_SOURCE_DIR}/VectorAdd.cpp)
# target_link_libraries(VectorAdd acpplib)
add_sycl_to_target(TARGET VectorAdd SOURCES ${CMAKE_SOURCE_DIR}/VectorAdd.cpp)