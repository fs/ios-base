//
//  ErrorHandler.h
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


#pragma mark -
@interface ErrorHandler : NSObject

@property (nonatomic, strong, readonly) AFHTTPRequestOperation *requestOperation;

+ (void)errorDescription:(NSDictionary *)errorDict key:(NSString **)resultKey reason:(NSString **)reasonError;

- (id)initFromFailureRequestOperation:(AFHTTPRequestOperation *)requestOperation;

- (NSString *)errorString;

@end


#pragma mark -
@interface NSError (Extended)

- (NSError *)errorByLocalizedDescription:(NSString *)description;

@end
