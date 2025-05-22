#!/usr/bin/bash

TIME="$(date +"%Y-%m-%d_%H:%M:%S")"
gh release create $(cat /proc/sys/kernel/random/uuid) --notes "${TIME}" ./out/arch/arm64/boot/*Image*
