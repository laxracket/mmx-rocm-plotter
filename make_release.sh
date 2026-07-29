#!/bin/bash

mkdir -p build

cd build

cmake -D CMAKE_BUILD_TYPE="Release" -D CMAKE_CXX_FLAGS="-fmax-errors=1" -D HIP_DIR=/opt/rocm/core-7.14/lib/cmake/hip ..

make -j16 $@