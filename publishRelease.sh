#!/usr/bin/bash

TIME="$(date +"%Y-%m-%d_%H:%M:%S")"
gh release create ${TIME} --notes "Build time: ${TIME}" ./out/arch/arm64/boot/*Image*
