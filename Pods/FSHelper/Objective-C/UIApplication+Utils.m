#import "UIApplication+Utils.h"


#pragma mark -
@implementation UIApplication (Utils)

+ (id<UIApplicationDelegate>)applicationDelegate
{
    return [[UIApplication sharedApplication] delegate];
}

- (CGFloat)shortVersion
{
    return [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] floatValue];
}

- (void)clearTemporaryDirectory
{
    NSString *pathToTemporaryDirectory      = NSTemporaryDirectory();
    NSArray *tmpDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pathToTemporaryDirectory
                                                                                error:nil];
    for (NSString *file in tmpDirectory)
    {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", pathToTemporaryDirectory, file]
                                                   error:nil];
    }
}

@end
