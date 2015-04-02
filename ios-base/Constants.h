//
//  Constants.h
//

#define API_TEST_CURRENT_DATE  0 && DEBUG

#if STAGING
    static NSString *const kBaseURL                 = @"http://staging.api.timezonedb.com/";
#else
    static NSString *const kBaseURL                 = @"http://api.timezonedb.com/";
#endif

/*----------Keys---------*/
static NSString *const kTimezoneAPIKey              = @"PF85Q4OP7VRG";