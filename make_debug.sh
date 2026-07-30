#!/bin/bash

mkdir -p build

cd build

HIP_CMAKE=""
for path in /opt/rocm/lib/cmake/hip /opt/rocm/core-7.14/lib/cmake/hip /opt/rocm/hip/lib/cmake/hip /opt/rocm/*/lib/cmake/hip; do
	if [ -d "$path" ]; then HIP_CMAKE="-D HIP_DIR=$path"; break; fi
done

cmake -D CMAKE_BUILD_TYPE="Debug" -D CMAKE_CXX_FLAGS="-fmax-errors=1" $HIP_CMAKE ..

make -j$(nproc) $@

