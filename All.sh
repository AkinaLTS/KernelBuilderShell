#!/usr/bin/bash 
# Copyright (c) 2026 Arkria. All rights reserved.
# Use for Github Codespace
# shellcheck source=/dev/null

# Make sure we have toolchain
# if not, run toolchain.sh to download
if [ ! -e "${HOME}/tc" ]; then
    echo "Error: Toolchain not found. abort."
    exit 1
fi

# install deps
source installDeps.sh

# build kernel
source build.sh || source publishErrorLog.sh

# update Image to release
source releaseImage.sh