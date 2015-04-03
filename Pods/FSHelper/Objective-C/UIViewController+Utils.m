#import "UIViewController+Utils.h"


#pragma mark -
@implementation UIViewController (Utils)

- (BOOL)isVisible
{
    if ([self isViewLoaded])
    {
        return self.view.window != nil;
    }
    return NO;
}

@end
