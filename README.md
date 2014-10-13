[![Build Status](https://api.travis-ci.org/fs/ios-base.svg?branch=master)](https://travis-ci.org/fs/ios-base)

# ios-base

ios-base is a iOS template project designed by iOS developers from [FlatStack](http://www.flatstack.com/)


## Get started

### Clone or download

To get started you can clone or download project as zip. To preset new project prefer download zip to keep commit history clean.

If you want to clone project copy to teminal this code:
```sh
git clone git@github.com:fs/ios-base.git
```

If you download project as zip you should create an empty Git repository. Unzip archive copy to terminal code:
```sh
cd Path/To/ios-base
git init
git remote add origin git@github.com:fs/some-git-repository.git
```
### Rename project
To rename project you should:

#### Change project name:
* In the Project Navigator on the left side, click twice slowly and the Project file name will be editable. Type the new name. A sheet will appear with a warning and will list all the items Xcode believes it should change.
* Accept the changes.

#### Remove mentions in code:
* Open search tab in the Project Navigator on the left side of Xcode.
* Search "ios-base" in project.
* Replace any occurrence of the ios-base name with the new project name.

#### Change folders names:
* Go to the project directory and rename all folders with name ios-base.
* Open the project and u will find all the file are missing, u need to add all the files of project again.
* Right click the project bundle .xcodeproj file and select “Show Package Contents” from the context menu. Open the .pbxproj file with any text editor.
* Search and replace any occurrence of the ios-base name with the new project name.
* Save the file.

#### Change schemes name:
* Right click the project bundle .xcodeproj file and select “Show Package Contents” from the context menu.
* Navigate to xcshareddata/xcschemes.
* Open all .xcscheme files with text editor.
* Replace any occurrence of the ios-base name with the new project name.
* Rename all .xcscheme files.

#### Rename workspace:
* Simple rename ios-base.xcworkspace with new project name.

### Configure CocoaPods
* Finde Podfile in project.
* Uncomment, add or remove pods.

```sh
platform :ios, '6.0'
pod 'BlocksKit'
pod 'AFNetworking'
pod 'SVProgressHUD'
pod 'TestFlightSDK'
#pod 'MagicalRecord'
#pod 'Reachability'
#pod 'SDWebImage'
#pod 'SSKeychain'
#pod 'NSData+Base64'
#pod 'MKStoreKit'
```

* Then run in terminal

```sh
pod install
```

### Configure mogenerator
* Configure CoreData and Mogenerator scripts in

```sh
/ios-base/Scripts 
```

### Configure Crashlytics
All about integration of [Crashlytics](http://try.crashlytics.com/) you can read [here](https://github.com/fs/guides/tree/master/services-and-tools/crashlytics).
### Configure Travis-CI
All about integration of [Travis-CI](https://travis-ci.org/) you can read [here](https://github.com/fs/guides/tree/master/services-and-tools/travis-ci).
### Last step
Last step of configuration project is removing all unnecessary files from project and edit **README.md**

## Included scripts

The project includes several useful scripts. For example [build.sh](https://github.com/fs/ios-base/blob/master/ios-base/Scripts/build.sh), [test.sh](https://github.com/fs/ios-base/blob/master/ios-base/Scripts/test.sh) and [oclint.sh](https://github.com/fs/ios-base/blob/master/ios-base/Scripts/oclint.sh).

Before push changes to GitHub you can check your project. You can build project, run tests or check code from terminale. To run one of scripts enter in terminale this lines:
```sh
sh ios-base/Scripts/build.sh 
```
```sh
sh ios-base/Scripts/test.sh 
```
```sh
sh ios-base/Scripts/oclint.sh 
```

WARNING!!! These scripts used by Travis-CI so you should not change them!

## Credits

Rails Base is maintained by [Nikita Fomin](http://github.com/nikitafomin).
It was written by [Flatstack](http://www.flatstack.com) with the help of our
[contributors](http://github.com/fs/ios-base/contributors).


[![Flatstack](https://avatars0.githubusercontent.com/u/15136?v=2&s=200)](http://www.flatstack.com)
