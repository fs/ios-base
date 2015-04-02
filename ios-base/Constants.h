//
//  Constants.h
//

#if STAGING
    static NSString *const kBaseURL                 = @"http://staging.api.timezonedb.com/";
#else
    static NSString *const kBaseURL                 = @"http://api.timezonedb.com/";
#endif

#define API_TEST_CURRENT_DATE  NO

/*----------Keys---------*/
static NSString *const kTimezoneAPIKey              = @"PF85Q4OP7VRG";