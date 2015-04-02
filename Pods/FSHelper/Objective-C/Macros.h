#import <Foundation/Foundation.h>

#define BLOCK_SAFE_RUN(block, ...)                  block ? block(__VA_ARGS__) : nil

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] floatValue] == v)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] floatValue] > v)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] floatValue] >= v)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] floatValue] < v)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] floatValue] <= v)

static inline void dispatch_after_in_main_queue(CGFloat delay, dispatch_block_t block)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
};

#pragma mark - MATH
static inline double degrees_to_radians(double degrees)
{
    return degrees * M_PI / 180.0;
}

static inline double radians_to_degrees(double radians)
{
    return radians * 180.0 / M_PI;
}

#pragma mark - DIRECTORIES
static inline NSString *path_for_directory(NSSearchPathDirectory searchPathDirectory)
{
    return [NSSearchPathForDirectoriesInDomains(searchPathDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - HARDWARE/DEVICE CAPABILITY
static inline BOOL is_ipad()
{
    return ([[UIDevice currentDevice].localizedModel isEqualToString:@"iPad"] || [[UIDevice currentDevice].localizedModel isEqualToString:@"iPad Simulator"]);
}

static inline BOOL is_iphone()
{
    return ([[UIDevice currentDevice].localizedModel isEqualToString:@"iPhone"] || [[UIDevice currentDevice].localizedModel isEqualToString:@"iPhone Simulator"]);
}

static inline BOOL is_retina()
{
    return ([UIScreen mainScreen].scale > 1.0);
}

static inline BOOL is_camera_available()
{
    return ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]);
}

static inline BOOL is_game_center_available()
{
    return (NSClassFromString(@"GKLocalPlayer") &&
            [[[UIDevice currentDevice] systemVersion] compare:@"4.1" options:NSNumericSearch] != NSOrderedAscending);
}

static inline BOOL is_email_account_available()
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    Class composerClass = NSClassFromString(@"MFMailComposeViewController");
    return [composerClass respondsToSelector:@selector(canSendMail)];
    
#pragma clang diagnostic pop
}

static inline BOOL is_gps_enabled_on_device()
{
    BOOL isLocationServicesEnabled = NO;
    
    Class locationClass            = NSClassFromString(@"CLLocationManager");
    SEL locationServicesEnabledSel = NSSelectorFromString(@"locationServicesEnabled");
    NSMethodSignature *signature   = [locationClass instanceMethodSignatureForSelector:locationServicesEnabledSel];
    NSInvocation *invocation       = [NSInvocation invocationWithMethodSignature:signature];
    
    [invocation invoke];
    [invocation getReturnValue:&isLocationServicesEnabled];
    
    return locationClass && isLocationServicesEnabled;
}

static inline BOOL is_gps_enabled_for_application()
{
    // for 4.2+ only, we can check down to the app level
#ifdef kCLAuthorizationStatusAuthorized
    Class locationClass                 = NSClassFromString(@"CLLocationManager");
    
    if ([locationClass respondsToSelector:@selector(authorizationStatus)])
    {
        NSInteger authorizationStatus   = kCLAuthorizationStatusNotDetermined;
        
        NSMethodSignature *signature    = [locationClass instanceMethodSignatureForSelector:@selector(authorizationStatus)];
        NSInvocation *invocation        = [NSInvocation invocationWithMethodSignature:signature];
        
        [invocation invoke];
        [invocation getReturnValue:&authorizationStatus];
        
        return locationClass && (authorizationStatus == kCLAuthorizationStatusAuthorized);
    }
#endif
    
    return YES;
}

static inline BOOL is_gps_enabled()
{
    return is_gps_enabled_on_device() && is_gps_enabled_for_application();
}
