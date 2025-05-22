#!/usr/bin/bash

TIME="$(date +"%Y-%m-%d_%H:%M:%S")"
TIME_ID="$(date +"%Y-%m-%d-%H-%M-%S")"
gh release create ${TIME_ID} --title "${TIME}" --notes "Build time: ${TIME}
Branch: 
$(git branch)" ./out/arch/arm64/boot/*Image*
