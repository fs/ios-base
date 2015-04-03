//
//  APIManager.h
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

@class AFHTTPRequestOperationManager;

#pragma mark -
@interface APIManager : NSObject

+ (APIManager*)sharedManager;

@property (nonatomic, strong, readonly) AFHTTPRequestOperationManager *operationManager;

#pragma mark - Date
- (AFHTTPRequestOperation *)getCurrentDateWithParams:(NSDictionary *)params completion:(void (^)(AFHTTPRequestOperation *operation, id responseObject))completion failed:(void (^)(AFHTTPRequestOperation *operation, NSError *error, BOOL isCancelled))failed;

@end

