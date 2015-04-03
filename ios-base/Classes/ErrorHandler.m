//
//  ErrorHandler.m
//

#import "ErrorHandler.h"


#pragma mark -
@implementation ErrorHandler

+ (void)errorDescription:(NSDictionary *)errorDict key:(NSString **)resultKey reason:(NSString **)resultReason {
    
    if ([errorDict isKindOfClass:[NSDictionary class]]) {
        
        id errors = [errorDict objectForKey:@"errors"];
        if (errors) {
            
            errorDict = errors;
        }
    }
    
    for (NSString *key in errorDict) {
        
        if ([key isEqualToString:@"status"]) {
            
            continue;
        }
        
        NSString *value = [errorDict objectForKey:key];
        if ([value isKindOfClass:[NSArray class]]) {
            
            value = [(NSArray *)value componentsJoinedByString:@", "];
        }
        
        if ([value isKindOfClass:[NSString class]]) {
            
            if (resultKey) {
                
                *resultKey = key;
            }
            
            if (resultReason) {
                
                *resultReason = value;
            }
            return;
            
        } else {
            
#if DEBUG
            NSLog(@"[ERROR API]Return parametr not as string %@", value);
#endif
        }
    }
}

- (id)initFromFailureRequestOperation:(AFHTTPRequestOperation *)requestOperation
{
    if (!requestOperation) {
        
        return nil;
    }
    
    self    = [super init];
    if (self) {
        
        _requestOperation = requestOperation;
    }
    return self;
}

- (NSString *)errorString {
    
    if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
        
        return NSLocalizedString(@"NO_INTERNET_CONNECTION", nil);
    }
    else
    if (!self.requestOperation.response) {
        
        return NSLocalizedString(@"SERVER_NOT_RESPOND", nil);
    } else {
        
        NSString *result = nil;
        switch (self.requestOperation.response.statusCode) {
                
            case 401:
            {
                result  = NSLocalizedString(@"USER_NOT_AUTHORIZED", nil);
            }; break;
                
            case 500:
            case 503:
            case 504:
            {
                result  = NSLocalizedString(@"SERVER_ERROR", nil);
            }; break;
                
            default:
            {
                result = [NSHTTPURLResponse localizedStringForStatusCode:self.requestOperation.response.statusCode];
            }; break;
        }

        if ([result length] == 0) {
            
            result   = NSLocalizedString(@"UNKNOWN_ERROR", nil);
        }
        
#if DEBUG
        NSLog(@"Error handler with operation \r\n %@; \r\n errorString = %@", _requestOperation, result);
#endif
        
        return result;
    }
}

@end


#pragma mark -
@implementation NSError (Extended)

- (NSError *)errorByLocalizedDescription:(NSString *)description {
    
    NSMutableDictionary *userInfo       = [self.userInfo mutableCopy];
    userInfo[NSLocalizedDescriptionKey] = description;
    
    return [NSError errorWithDomain:self.domain code:self.code userInfo:userInfo];
}

@end
