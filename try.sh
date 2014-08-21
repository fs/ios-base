#!/bin/sh

# xcodebuild -workspace ios-base.xcworkspace -scheme ios-base-Production -sdk iphoneos -configuration Release OBJROOT=$PWD/build SYMROOT=$PWD/build ONLY_ACTIVE_ARCH=NO | xcpretty -c && exit ${PIPESTATUS[0]}

xcodebuild -workspace ios-base.xcworkspace -scheme ios-base-Staging -destination 'platform=iOS Simulator,name=iPhone Retina (4-inch),OS=7.1' test | xcpretty -c && exit ${PIPESTATUS[0]}


