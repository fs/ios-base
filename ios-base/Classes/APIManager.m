//
//  APIManager.m
//  ios-base
//
//  Created by Danis Ziganshin on 14.02.14.
//  Copyright (c) 2014 FlatStack. All rights reserved.
//

#import "APIManager.h"
#import "AFNetworking.h"

//Get info about this API on http://timezonedb.com/api
#define BASE_URL @"http://api.timezonedb.com/"
#define API_KEY @"PF85Q4OP7VRG"

@implementation APIManager

+ (APIManager*)sharedManager {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)getCurrentDateWithCompleteBlock:(ObjectCallback)block {
    NSString *fullURL = [NSString stringWithFormat:@"%@",BASE_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{ @"zone": @"Europe/Moscow",
                              @"key": API_KEY,
                              @"format": @"json" };
    [manager GET:fullURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSTimeInterval timeInterval = [[responseObject objectForKeyOrNil:@"timestamp"] doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        BLOCK_SAFE_RUN(block, date);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BLOCK_SAFE_RUN(block, NO);
    }];
}

@end
