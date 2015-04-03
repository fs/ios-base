//
//  FSDate.m
//

#import "FSDate.h"

#pragma mark -
@implementation FSDate

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    
    [super updateWithDictionary:dictionary];
    
    self.abbreviation   = dictionary[@"abbreviation"];
    self.countryCode    = dictionary[@"countryCode"];
    self.dst            = dictionary[@"dst"];
    self.gmtOffset      = dictionary[@"gmtOffset"];
    self.message        = dictionary[@"message"];
    self.status         = dictionary[@"status"];
    self.timestamp      = dictionary[@"timestamp"];
    self.zoneName       = dictionary[@"zoneName"];
}

- (NSString *)formattedString {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.timestamp integerValue]];
    
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    
    return [dateFormatter stringFromDate:date];
}

#pragma mark - API

+ (AFHTTPRequestOperation *)API_getCurrentDateWithCompletion:(void (^)(AFHTTPRequestOperation *operation, FSDate *date))completion failed:(void (^)(AFHTTPRequestOperation *operation, NSError *error, BOOL isCancelled))failed {
    
    NSDictionary *params = @{
                             @"zone"        : @"Europe/Moscow",
                             @"key"         : kTimezoneAPIKey,
                             @"format"      : @"json"
                             };
    
    AFHTTPRequestOperation* operation =
    [[APIManager sharedManager] getCurrentDateWithParams:params completion:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        FSDate *date    = [[FSDate alloc] init];
        [date updateWithDictionary:responseObject];
        
        BLOCK_SAFE_RUN(completion, operation, date);
        
    } failed:failed];
    
    return operation;
}

@end



