#!/bin/sh
xcodebuild -workspace ios-base.xcworkspace -scheme ios-base-Production -sdk iphoneos -configuration Release OBJROOT=$PWD/build SYMROOT=$PWD/build ONLY_ACTIVE_ARCH=NO | xcpretty -c && exit ${PIPESTATUS[0]}
