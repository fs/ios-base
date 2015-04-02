#import "UITabBarController+Utils.h"


#pragma mark -
@implementation UITabBarController (Utils)

- (void)hiddenTabBar:(BOOL)hidden
            animated:(BOOL)animated
{
    if (!animated)
    {
        [self.tabBar setHidden:hidden];
    }
    else
    {
        [self.tabBar setUserInteractionEnabled:NO];
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        __weak typeof(self) wself       = self;
        [UIView animateWithDuration:0.5f animations:^{
            CGFloat fHeight = 0.0f;
            if (hidden)
            {
                if (UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
                {
                    fHeight = screenRect.size.width;
                }
                else
                {
                    fHeight = screenRect.size.height;
                }
            }
            else
            {
                if (UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
                {
                    fHeight = screenRect.size.width - wself.tabBar.frame.size.height;
                }
                else
                {
                    fHeight = screenRect.size.height - wself.tabBar.frame.size.height;
                }
            }
            
            [wself.tabBar setFrame:CGRectMake(wself.tabBar.frame.origin.x,
                                              fHeight,
                                              wself.tabBar.frame.size.width,
                                              wself.tabBar.frame.size.height)];
            
        } completion:^(BOOL finished) {
            [wself.tabBar setUserInteractionEnabled:YES];
        }];
    }
}

@end
