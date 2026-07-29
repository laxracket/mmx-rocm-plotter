# mmx-rocm-plotter

ROCm (HIP) plotter to create plots for the [MMX](https://github.com/madMAx43v3r/mmx-node) network on AMD GPUs.

## Requirements

- AMD GPU with ROCm support (developed/tested on gfx1201 / Radeon AI PRO R9700)
- ROCm 7.x (HIP runtime and compiler)
- CMake 3.10+, C++17 toolchain
- Linux (primary)

## Build

```bash
git submodule update --init --recursive   # if using submodules
./make_release.sh
# or:
mkdir -p build && cd build
cmake -D CMAKE_BUILD_TYPE=Release -D HIP_DIR=/opt/rocm/lib/cmake/hip ..
make -j$(nproc)
```

Binaries: `mmx_rocm_plot_k26` … `mmx_rocm_plot_k32`.

Ensure the HIP libraries are on the loader path, e.g.:

```bash
export LD_LIBRARY_PATH=/opt/rocm/lib:$LD_LIBRARY_PATH
```

## Usage

Example Full RAM: `./mmx_rocm_plot_k30 -C 5 -n -1 -t /mnt/tmp_ssd/ -d <dst> -f <farmer_key>`

Example Partial RAM: `./mmx_rocm_plot_k30 -C 5 -n -1 -2 /mnt/tmp_ssd/ -d <dst> -f <farmer_key>`

Example Disk Mode: `./mmx_rocm_plot_k30 -C 5 -n -1 -3 /mnt/tmp_ssd/ -d <dst> -f <farmer_key>`

Example dual-GPU (single plot, work split across GPUs):  
`./mmx_rocm_plot_k30 -g 0 -r 2 -C 0 -t /mnt/tmp/ -f <farmer_key>`

For maximum throughput on two GPUs, prefer two single-GPU processes (`-r 1`) with separate temp directories.

CLI usage is analogous to Gigahorse ([cuda-plotter](https://github.com/madMAx43v3r/chia-gigahorse/tree/master/cuda-plotter)), without `-p` pool key.

If you have a fast CPU ([passmark benchmark](https://www.cpubenchmark.net) > 5000 points) you can use `-C 10` for HDD plots.

To create SSD plots (for farming on SSDs) add `--ssd` to the command and use `-C 0`.  
SSD plots are 250% more efficient but cannot be farmed on HDDs. They have higher CPU load to farm, hence it's recommended to plot uncompressed.

## Attribution / provenance

This project was adapted from the original **mmx-cuda-plotter** by madMAx43v3r:

- https://github.com/madMAx43v3r/mmx-cuda-plotter

The port to AMD ROCm/HIP (including build system changes, API migration, and platform-specific fixes) was produced with AI assistance. Plot file format and MMX proof-of-space algorithms remain those of the upstream MMX/cuda-plotter design.
