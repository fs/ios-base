ios-base
=========

ios-base is a iOS template project

 
Installation
--------------

```sh
git clone git@github.com:fs/ios-base.git
cd ios-base
pod install
```

### Configure CocoaPods

* Uncomment, add or remove pods in Podfile

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

* Configure CoreData and Mogenerator scripts in
```sh
/ios-base/Scripts 
```

* Configure Testflight key
* Configure APIManager to use your API

    