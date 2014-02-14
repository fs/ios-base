//
//  Constants.h
//  ios-base
//
//  Created by Danis Ziganshin on 14.02.14.
//  Copyright (c) 2014 FlatStack. All rights reserved.
//

#ifndef ios_base_Constants_h
#define ios_base_Constants_h

#define kTestflightAppToken @"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

/*------------debugging------------*/
#ifdef DEBUG
#define DLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#define ALog(...) [[NSAssertionHandler currentHandler] handleFailureInFunction:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] file:[NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding] lineNumber:__LINE__ description:__VA_ARGS__]
#else
#define DLog(...) do { } while (0)
#ifndef NS_BLOCK_ASSERTIONS
#define NS_BLOCK_ASSERTIONS
#endif
#define ALog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#endif

#define ZAssert(condition, ...) do { if (!(condition)) { ALog(__VA_ARGS__); }} while(0)

/*------------typedefs------------*/
typedef void(^DictionaryCallback)(NSDictionary* resultDict);
typedef void(^ArrayCallback)(NSArray* resultArray);
typedef void(^BOOLCallback)(BOOL success);
typedef void(^Callback)(void);
typedef void(^ProgressFloatCallback)(float progress);
typedef void(^ObjectCallback)(id object);

/*----------Notifications---------*/
static NSString *const kMockNotification = @"mock_notification";

#endif
