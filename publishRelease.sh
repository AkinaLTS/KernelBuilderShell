#!/usr/bin/bash
# Copyright (c) 2025 Arkria. All Rights Reserved.

TIME="$(date +"%Y-%m-%d_%H:%M:%S")"
TIME_ID="$(date +"%Y-%m-%d-%H-%M-%S")"
FILES=""

if [[ -f "./out/arch/arm64/boot/*Image*" ]]; then
    echo "Find Image."
    FILES+="./out/arch/arm64/boot/*Image*"
else
    echo "No Image file."
fi
if [[ -f "out/arch/arm64/boot/*dtb*" ]]; then
    echo "Find dtb dtbo."
    FILES+="./out/arch/arm64/boot/*dtb*"
else
    echo "No dtb dtbo files."
fi

if [[ -n "${FILES}" ]]; then
    echo "Nothing can be uploaded. Exited."
    exit 1
fi

gh release create ${TIME_ID} --title "${TIME}" --notes "Build time: ${TIME} \ 
    Branch: \ 
    $(git branch --show-current) \ 
    Commit Message: \ 
    $(git show --no-patch)" ${FILES}
