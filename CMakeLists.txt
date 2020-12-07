cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(TempestRemap VERSION 2.0.5 HOMEPAGE_URL "https://github.com/ClimateGlobalChange/tempestremap" LANGUAGES CXX)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

set(LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(CMAKE_CXX_STANDARD 11)

find_package(NetCDF COMPONENTS C REQUIRED)
find_package(LAPACK REQUIRED)

add_subdirectory(src)

include(CTest)
add_subdirectory(test)

