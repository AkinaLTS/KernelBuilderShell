#!/usr/bin/bash

# clang main-kernel clang-stable
TCURL="https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/main-kernel/clang-r547379.tar.gz"
aria2c "${TCURL}"
