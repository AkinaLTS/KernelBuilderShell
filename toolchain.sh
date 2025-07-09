#!/usr/bin/bash
# Copyright (c) 2025 Arkria. All Rights Reserved.

# clang main-kernel clang-stable
TCURL="https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/main-kernel/clang-r547379.tar.gz"

wget "${TCURL}" -O ~/tc.tgz

mkdir -p ~/tc
tar xvf ~/tc.tgz -C ~/tc
