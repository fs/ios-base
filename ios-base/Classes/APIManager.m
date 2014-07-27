//
//  APIManager.m
//  ios-base
//
//  Created by Danis Ziganshin on 14.02.14.
//  Copyright (c) 2014 FlatStack. All rights reserved.
//

#import "APIManager.h"
#import "AFNetworking.h"
#import "KeysManager.h"

#warning checkout code and remove API_KEY and rename BASE_URL for staging and production
//Get info about this API on http://timezonedb.com/api

static NSString *BASE_URL;

@implementation APIManager

+ (APIManager*)sharedManager {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        if ([[[NSBundle mainBundle] bundleIdentifier] hasSuffix:@"staging"])
        {
            BASE_URL = [[KeysManager getKeysFamily:TZ_API] objectForKeyOrNil:BASE_URL_STAGING_KEY];
        }
        else
        {
            BASE_URL = [[KeysManager getKeysFamily:TZ_API] objectForKeyOrNil:BASE_URL_KEY];
        }
    });
    return sharedInstance;
}

- (void)getCurrentDateWithCompleteBlock:(ObjectCallback)block
{
    NSDictionary *APIFamily = [KeysManager getKeysFamily:TZ_API];
    
    NSString *fullURL = [BASE_URL copy];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{ @"zone": @"Europe/Moscow",
                              @"key": [APIFamily objectForKeyOrNil:API_KEY],
                              @"format": @"json" };
    [manager GET:fullURL parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSTimeInterval timeInterval = [[responseObject objectForKeyOrNil:@"timestamp"] doubleValue];
         NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
         BLOCK_SAFE_RUN(block, date);
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         BLOCK_SAFE_RUN(block, NO);
     }];
}

@end
