#!/bin/sh

# install oclint from resources
cp oclint/bin/oclint* /usr/local/bin/
cp -rp oclint/lib/* /usr/local/lib/

# clean previous output
if [ -f xcodebuild.log ]; then
    rm xcodebuild.log
fi

# clean project
xcodebuild clean > /dev/null

# create xcodebuild.log file
xcodebuild -workspace ios-base.xcworkspace -scheme ios-base-Production -sdk iphoneos -configuration Release OBJROOT=$PWD/build SYMROOT=$PWD/build ONLY_ACTIVE_ARCH=NO | tee xcodebuild.log > /dev/null

# create compile_commands.json file
oclint-xcodebuild


# run analizer
# more info about rules see here
# http://docs.oclint.org/en/dev/rules/
# http://docs.oclint.org/en/dev/rules/size.html
# http://docs.oclint.org/en/dev/customizing/rules.html
# http://docs.oclint.org/en/dev/manual/oclint.html
# http://docs.oclint.org/en/dev/devel/rules.html
#

oclint-json-compilation-database -e Pods* -- \
    -max-priority-1=0 \
    -max-priority-2=100 \
    -max-priority-3=1000 \
    -rc NCSS_METHOD=100
