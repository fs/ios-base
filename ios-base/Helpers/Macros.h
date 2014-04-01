
#define ApplicationDelegate                 ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define ApplicationDirectoryPath(DirectoryToSearch) ((NSString *)[NSSearchPathForDirectoriesInDomains(DirectoryToSearch, NSUserDomainMask, YES) objectAtIndex:0])
#define ApplicationDirectoryURL(DirectoryToSearch) ((NSURL *)[[[NSFileManager defaultManager] URLsForDirectory:DirectoryToSearch inDomains:NSUserDomainMask] lastObject])
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define SharedApplication                   [UIApplication sharedApplication]
#define Bundle                              [NSBundle mainBundle]
#define ShowNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define TouchHeightDefault                  44
#define TouchHeightSmall                    32
#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define IS_IPAD                             ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
#define IS_IPHONE                           ([UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPad)
#define IS_IPHONE_5                         ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IOS_7                            ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0f)
#define IS_RETINA                           ([UIScreen mainScreen].scale==2.0)
#define IS_LANDSCAPE                        UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
#define ONE_PIXEL                           (1.0f / [UIScreen mainScreen].scale)
#define BLOCK_SAFE_RUN(block, ...)          block ? block(__VA_ARGS__) : nil

/*
 *  System Versioning Preprocessor Macros
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
