#import <UIKit/UIKit.h>


#pragma mark -
@interface UIDevice (Space)

- (long long)totalDiskSpace;
- (long long)freeDiskSpace;
- (long long)usedDiskSpace;

@end