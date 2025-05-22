#!/usr/bin/bash

TIME="$(date +"%Y-%m-%d_%H:%M:%S")"
gh release create ${TIME} --notes "Build time: ${TIME}
Branch: $(git branch)" ./out/arch/arm64/boot/*Image*
