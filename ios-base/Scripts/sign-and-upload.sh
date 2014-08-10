#!/bin/sh
if [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then
echo "This is a pull request. No deployment will be done."
exit 0
fi
if [[ "$TRAVIS_BRANCH" != "master" ]]; then
echo "Testing on a branch other than master. No deployment will be done."
exit 0
fi

PROVISIONING_PROFILE="$HOME/Library/MobileDevice/Provisioning Profiles/$PROFILE_NAME.mobileprovision"
OUTPUTDIR="$PWD/build/Release-iphoneos"

echo ""
echo "********************"
echo "* Signing *"
echo "********************"
echo ""

xcrun -log -sdk iphoneos PackageApplication "$OUTPUTDIR/$APP_NAME.app" -o "$OUTPUTDIR/$APP_NAME.ipa" -sign "$DEVELOPER_NAME" -embed "$PROVISIONING_PROFILE"
zip -r -9 "$OUTPUTDIR/$APP_NAME.app.dSYM.zip" "$OUTPUTDIR/$APP_NAME.app.dSYM"

echo ""
echo "********************"
echo "* Uploading *"
echo "********************"
echo ""

RELEASE_DATE=`date '+%Y-%m-%d %H:%M:%S'`
RELEASE_NOTES="This version was uploaded automagically by Travis\nTravis Build number $TRAVIS_BUILD_NUMBER\nUploaded: $RELEASE_DATE\nCommits in push/pull request: $TRAVIS_COMMIT_RANGE\nLast commit: $TRAVIS_COMMIT\nLast commit message: $TRAVIS_COMMIT_MESSAGE"

curl http://testflightapp.com/api/builds.json \
-F file="@$OUTPUTDIR/$APP_NAME.ipa" \
-F dsym="@$OUTPUTDIR/$APP_NAME.app.dSYM.zip" \
-F api_token="$TESTFLIGHT_API_TOKEN" \
-F team_token="$TESTFLIGHT_TEAM_TOKEN" \
-F distribution_lists='developers' \
-F notes="$RELEASE_NOTES"
