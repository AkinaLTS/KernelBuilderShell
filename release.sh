#!/bin/bash

BUILD_DIR="out/arch/arm64/boot"
RELEASE_TIME="$(date "+%y-%m-%d_%H-%M-%S")"
PRETTY_TIME="$(date "+%y/%m/%d %H:%M:%S")"
RELEASE_NAME="Build_${PRETTY_TIME}"
RELEASE_TAG="v${RELEASE_TIME}"

echo "Preparing files for GitHub release from ${BUILD_DIR}..."

FILES_TO_UPLOAD=()

if [ -f "${BUILD_DIR}/Image" ]; then
    echo "Found ${BUILD_DIR}/Image."
    FILES_TO_UPLOAD+=("${BUILD_DIR}/Image")
else
    echo "Warning: ${BUILD_DIR}/Image not found. Skipping."
fi

if [ -f "${BUILD_DIR}/dtb" ]; then
    echo "Found ${BUILD_DIR}/dtb."
    FILES_TO_UPLOAD+=("${BUILD_DIR}/dtb")
else
    echo "Warning: ${BUILD_DIR}/dtb not found. Skipping."
fi

if [ -f "${BUILD_DIR}/dtbo.img" ]; then
    echo "Found ${BUILD_DIR}/dtbo.img."
    FILES_TO_UPLOAD+=("${BUILD_DIR}/dtbo.img")
else
    echo "Warning: ${BUILD_DIR}/dtbo.img not found. Skipping."
fi

if [ -f "out/.config" ]; then
    echo "Found .config."
    cp out/{.config,build_config}
    FILES_TO_UPLOAD+=("out/build_config")
else
    echo "Warning: .config not found. Skipping."
fi

if [ ${#FILES_TO_UPLOAD[@]} -eq 0 ]; then
    echo "No files found to upload for the release. Aborting."
    exit 0
fi

echo "Proceeding with GitHub release for tag '${RELEASE_TAG}'..."

GH_UPLOAD_ARGS=()
for file in "${FILES_TO_UPLOAD[@]}"; do
    GH_UPLOAD_ARGS+=("${file}")
done

gh release create "${RELEASE_TAG}" \
    "${GH_UPLOAD_ARGS[@]}" \
    --title "${RELEASE_NAME}" \
    --notes "
    Time: ${PRETTY_TIME}
    Branch: $(git branch --show-current)
    Committer: $(git log --pretty=format:"%cn" -1)
    CommitID: $(git rev-parse --short HEAD)
    Commit: $(git log --pretty=format:"%s" -1)
    "

if [ $? -ne 0 ]; then
    echo "Error: Failed to create GitHub release. Check the error message above."
    exit 1
else
    echo "GitHub release '${RELEASE_NAME}' created successfully!"
fi
