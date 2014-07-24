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

//Get info about this API on http://timezonedb.com/api

@implementation APIManager

+ (APIManager*)sharedManager {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)getCurrentDateWithCompleteBlock:(ObjectCallback)block
{
    NSDictionary *APIFamily = [KeysManager getKeysFamily:TZ_API];
    
    NSString *fullURL = [[APIFamily objectForKeyOrNil:BASE_URL_KEY] copy];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{ @"zone": @"Europe/Moscow",
                              @"key": API_KEY,
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
