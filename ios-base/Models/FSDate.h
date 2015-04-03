//
//  FSDate.h
//

#import "FSObject.h"

#pragma mark -
@interface FSDate : FSObject

@property (nonatomic, strong) NSString *abbreviation;
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSNumber *dst;
@property (nonatomic, strong) NSNumber *gmtOffset;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSNumber *timestamp;
@property (nonatomic, strong) NSString *zoneName;

- (NSString *)formattedString;

#pragma mark - API

+ (AFHTTPRequestOperation *)API_getCurrentDateWithCompletion:(void (^)(AFHTTPRequestOperation *operation, FSDate *date))completion failed:(void (^)(AFHTTPRequestOperation *operation, NSError *error, BOOL isCancelled))failed;

@end
