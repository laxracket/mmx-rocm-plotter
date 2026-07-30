#!/bin/bash

mkdir -p build

cd build

# Try common ROCm HIP cmake locations (both classic 6.x and modular 7.x layouts)
# Fall back to letting cmake auto-discover if none found
HIP_CMAKE=""
for path in \
	/opt/rocm/lib/cmake/hip \
	/opt/rocm/core-7.14/lib/cmake/hip \
	/opt/rocm/hip/lib/cmake/hip \
	/opt/rocm/*/lib/cmake/hip; do
	if [ -d "$path" ]; then HIP_CMAKE="-D HIP_DIR=$path"; break; fi
done

cmake -D CMAKE_BUILD_TYPE="Release" -D CMAKE_CXX_FLAGS="-fmax-errors=1" $HIP_CMAKE ..

make -j$(nproc) $@
