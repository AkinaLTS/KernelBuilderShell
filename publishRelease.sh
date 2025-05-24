#!/usr/bin/bash
# Copyright (c) 2025 Arkria. All Rights Reserved.

TIME="$(date +"%Y-%m-%d_%H:%M:%S")"
TIME_ID="$(date +"%Y-%m-%d-%H-%M-%S")"
gh release create ${TIME_ID} --title "${TIME}" --notes "Build time: ${TIME} \ 
    Branch: \
    $(git branch --show-current) \
    Commit Message: \
    $(git show --no-patch)" ./out/arch/arm64/boot/*Image*
