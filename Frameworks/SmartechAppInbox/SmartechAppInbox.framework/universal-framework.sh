#!/bin/sh

#  universal-framework.sh
#  SmartechAppInbox
#
#  Created by Netcore Solutions on 25/05/20.
#  Copyright © 2020 Netcore Solutions. All rights reserved.

SDK_VERSION=`sed -n '/MARKETING_VERSION/{s/MARKETING_VERSION = //;s/;//;s/^[[:space:]]*//;p;q;}' ./SmartechAppInbox.xcodeproj/project.pbxproj`
echo "SmartechAppInbox SDK Creation Script SDK v${SDK_VERSION}"

SDK_OUTPUT_DIR="./SmartechAppInbox-Release-SDK/v${SDK_VERSION}"
FRAMEWORK_NAME="SmartechAppInbox"
WORKSPACE_PATH="../Smartech.xcworkspace"
SCHEME_NAME="SmartechAppInbox"

# Avilable Platforms/Architectures
# macosx | iphoneos | iphonesimulator | appletvos | appletvsimulator | watchos | watchsimulator
DEVICE_ARCH="iphoneos"
DEVICE_SIM_ARCH="iphonesimulator"


BUILD_PATH="${SRCROOT}/build"

# If remnants from a previous build exist, delete them.
rm -rf "${BUILD_PATH}"
mkdir "${BUILD_PATH}"

# Device Framework Path
DEVICE_FRAMEWORK_PATH="${BUILD_PATH}/${CONFIGURATION}-${DEVICE_ARCH}/${FRAMEWORK_NAME}.framework"

# Simulator Framework Path
SIMULATOR_FRAMEWORK_PATH="${BUILD_PATH}/${CONFIGURATION}-${DEVICE_SIM_ARCH}/${FRAMEWORK_NAME}.framework"

# Device BCSymboal Map
DEVICE_BCSYMBOLMAP_PATH="${BUILD_PATH}/${CONFIGURATION}-${DEVICE_ARCH}"

# Device DYSM Path
DEVICE_DSYM_PATH="${BUILD_PATH}/${CONFIGURATION}-${DEVICE_ARCH}/${FRAMEWORK_NAME}.framework.dSYM"

# Simulator DYSM Path
SIMULATOR_DSYM_PATH="${BUILD_PATH}/${CONFIGURATION}-${DEVICE_SIM_ARCH}/${FRAMEWORK_NAME}.framework.dSYM"

# Universal Framework Path
UNIVERSAL_LIBRARY_DIR="${BUILD_PATH}/${CONFIGURATION}-Universal"

FRAMEWORK="${UNIVERSAL_LIBRARY_DIR}/${FRAMEWORK_NAME}.framework"

echo "Building for Device"
xcodebuild -workspace "${WORKSPACE_PATH}" -scheme "${SCHEME_NAME}" -configuration Release BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="-fembed-bitcode" ONLY_ACTIVE_ARCH=NO -arch arm64 -arch armv7 -arch armv7s -sdk "${DEVICE_ARCH}" BUILD_DIR="${BUILD_PATH}" -UseModernBuildSystem=NO

echo "Building for Simulator"
xcodebuild -workspace "${WORKSPACE_PATH}" -scheme "${SCHEME_NAME}" -configuration Release BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="-fembed-bitcode" ONLY_ACTIVE_ARCH=NO -arch x86_64 -arch i386 -sdk "${DEVICE_SIM_ARCH}" BUILD_DIR="${BUILD_PATH}" -UseModernBuildSystem=NO

rm -rf "${UNIVERSAL_LIBRARY_DIR}"

mkdir "${UNIVERSAL_LIBRARY_DIR}"

mkdir "${FRAMEWORK}"

# Output Folder
rm -rf "$SDK_OUTPUT_DIR"
mkdir -p "$SDK_OUTPUT_DIR"

cp -r "${DEVICE_FRAMEWORK_PATH}/." "${FRAMEWORK}"

# Lipo to combine the Device + Simulator
lipo -create -output "${FRAMEWORK}/${FRAMEWORK_NAME}" "${DEVICE_FRAMEWORK_PATH}/${FRAMEWORK_NAME}" "${SIMULATOR_FRAMEWORK_PATH}/${FRAMEWORK_NAME}" || exit 1

cp -r "${FRAMEWORK}" "$SDK_OUTPUT_DIR"

cp -r "${DEVICE_DSYM_PATH}" "$SDK_OUTPUT_DIR"

# # To Create DYSM File
lipo -create -output "$SDK_OUTPUT_DIR/${FRAMEWORK_NAME}.framework.dSYM/Contents/Resources/DWARF/${FRAMEWORK_NAME}" \
"${DEVICE_DSYM_PATH}/Contents/Resources/DWARF/${FRAMEWORK_NAME}" \
"${SIMULATOR_DSYM_PATH}/Contents/Resources/DWARF/${FRAMEWORK_NAME}" || exit 1

# # To Create BCSymbolsMap
UUIDs=$(dwarfdump --uuid "${DEVICE_DSYM_PATH}" | cut -d ' ' -f2)
echo ${UUIDs}
for file in `find "${DEVICE_BCSYMBOLMAP_PATH}" -name "*.bcsymbolmap" -type f`; do
    fileName=$(basename "$file" ".bcsymbolmap")
    for UUID in $UUIDs; do
        if [[ "$UUID" = "$fileName" ]]; then
            cp -R "$file" "$SDK_OUTPUT_DIR"
            dsymutil --symbol-map "$SDK_OUTPUT_DIR"/"$fileName".bcsymbolmap "$SDK_OUTPUT_DIR/${FRAMEWORK_NAME}.framework.dSYM"
        fi
    done
done

# Deleting the build folder.
if [ -d "${BUILD_PATH}" ]; then
    rm -rf "${BUILD_PATH}"
fi

open "${SDK_OUTPUT_DIR}"

osascript -e 'display notification "SmartechAppInbox SDK" with title "Framework Ready To Release"'
