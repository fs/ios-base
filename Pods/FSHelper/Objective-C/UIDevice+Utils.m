#import "UIDevice+Utils.h"


#pragma mark -
@implementation UIDevice (Space)

- (long long)totalDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [[fattributes objectForKey:NSFileSystemSize] longLongValue];
}

- (long long)freeDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [[fattributes objectForKey:NSFileSystemFreeSize] longLongValue];
}

- (long long)usedDiskSpace
{
    return [self totalDiskSpace] - [self freeDiskSpace];
}

@end