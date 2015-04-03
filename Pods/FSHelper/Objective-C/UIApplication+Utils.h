#import <UIKit/UIKit.h>


#pragma mark -
@interface UIApplication (Utils)

+ (id<UIApplicationDelegate>)applicationDelegate;

- (CGFloat)shortVersion;

- (void)clearTemporaryDirectory;

@end
