#!/bin/sh
xcodebuild -workspace ios-base.xcworkspace -scheme ios-base-Staging -destination 'platform=iOS Simulator,name=iPhone Retina (4-inch),OS=7.1' test | xcpretty -c -t && exit ${PIPESTATUS[0]}
