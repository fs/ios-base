//
//  APIManager.m
//

#import "APIManager.h"
#import "ErrorHandler.h"

static APIManager *sharedInstance = nil;

#pragma mark -
@implementation APIManager

@synthesize operationManager = _operationManager;

+ (instancetype)sharedManager
{
    @synchronized(sharedInstance) {
        
        if (!sharedInstance) {
            
            sharedInstance = [self new];
        }
    }
    return sharedInstance;
}

- (id)init
{
    static dispatch_once_t onceTokenAPIManager;
    dispatch_once(&onceTokenAPIManager, ^{
        sharedInstance = [super init];
        if (sharedInstance) {
            //initialization
        }
    });
    
    return sharedInstance;
}

#pragma mark - Date
- (AFHTTPRequestOperationManager *)operationManager {
    
    if (!_operationManager) {
        
        NSURL *baseURL  = [NSURL URLWithString:kBaseURL];
        AFHTTPRequestOperationManager *operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
        
        operationManager.requestSerializer      = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
        operationManager.responseSerializer     = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        _operationManager = operationManager;
    }
    return _operationManager;
}

- (AFHTTPRequestOperation *)getCurrentDateWithParams:(NSDictionary *)params completion:(void (^)(AFHTTPRequestOperation *operation, id responseObject))completion failed:(void (^)(AFHTTPRequestOperation *operation, NSError *error, BOOL isCancelled))failed {
    
#if API_TEST_CURRENT_DATE
    NSURL *bootstrapURL = [[NSBundle mainBundle] URLForResource:@"date" withExtension:@"json"];
    NSData *data        = [[NSData alloc] initWithContentsOfURL:bootstrapURL];
    id responseObject   = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    BLOCK_SAFE_RUN(completion, nil, responseObject);
    
    return nil;
    
#else
    AFHTTPRequestOperation *operation =
    [[self operationManager] GET:@""
                      parameters:params
                         success:completion
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             
                             if (operation.isCancelled) {
                                 
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     BLOCK_SAFE_RUN(failed, operation, nil, YES);
                                 });
                             } else {
                                 
                                 NSString *errorDescription = nil;
                                 switch (operation.response.statusCode) {
                                     case 422:
                                     {
                                         errorDescription           = @"Missing parameters";
                                     }; break;
                                         
                                     default:
                                     {
                                         ErrorHandler *errorHandler =
                                         [[ErrorHandler alloc] initFromFailureRequestOperation:operation];
                                         errorDescription           = [errorHandler errorString];
                                     }; break;
                                 }
                                 
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     BLOCK_SAFE_RUN(failed, operation, [error errorByLocalizedDescription:errorDescription], NO);
                                 });
                             }
                         }];
    return operation;
#endif
}

@end



