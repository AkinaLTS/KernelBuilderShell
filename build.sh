#!/bin/bash
# Copyright (c) 2025 Aryan@CuriousNom. All Rights Reserved.
#
# Modified by Arkria.

# Ensure the script exits on error
set -e

TOOLCHAIN_PATH=$HOME/tc/bin
GIT_COMMIT_ID=$(git rev-parse --short=8 HEAD)

if [ ! -d $TOOLCHAIN_PATH ]; then
    echo "TOOLCHAIN_PATH [$TOOLCHAIN_PATH] does not exist."
    echo "Please ensure the toolchain is there, or change TOOLCHAIN_PATH in the script to your toolchain path."
    exit 1
fi

echo "TOOLCHAIN_PATH: [$TOOLCHAIN_PATH]"
export PATH="$TOOLCHAIN_PATH:$PATH"

if ! command -v aarch64-linux-gnu-ld >/dev/null 2>&1; then
    echo "[aarch64-linux-gnu-ld] does not exist, please check your environment."
    exit 1
fi

if ! command -v arm-linux-gnueabi-ld >/dev/null 2>&1; then
    echo "[arm-linux-gnueabi-ld] does not exist, please check your environment."
    exit 1
fi

if ! command -v clang >/dev/null 2>&1; then
    echo "[clang] does not exist, please check your environment."
    exit 1
fi

# Enable ccache for speed up compiling
export CCACHE_DIR="$HOME/.cache/ccache_mikernel"
export CC="ccache gcc"
export CXX="ccache g++"
export PATH="/usr/lib/ccache:$PATH"
echo "CCACHE_DIR: [$CCACHE_DIR]"

MAKE_ARGS="ARCH=arm64 O=out CC=clang LLVM=1 LLVM_IAS=1 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabi- AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip"

# Check clang is existing.
echo "[clang --version]:"
clang --version

# Export variables
export KBUILD_BUILD_USER="Arkria"
export KBUILD_BUILD_HOST="ArkriaBuild"
export KBUILD_LAST_COMMIT=${GIT_COMMIT_ID}

echo "Cleaning..."
rm -rf out/
rm -rf error.log

# ------------- Building for AOSP ---------------
echo "Clearing [out/] and building for AOSP....."

make $MAKE_ARGS $1

make $MAKE_ARGS -j$(nproc --all) 2> >(tee -a error.log >&2)

if [ -f "out/arch/arm64/boot/Image" ]; then
    echo "The file [out/arch/arm64/boot/Image] exists. AOSP Build successfully."
else
    echo "The file [out/arch/arm64/boot/Image] does not exist. Seems AOSP build failed."
    exit 1
fi

echo "Build for AOSP finished."
