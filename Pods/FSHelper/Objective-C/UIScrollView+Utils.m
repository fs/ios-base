#import "UIScrollView+Utils.h"


#pragma mark -
@implementation UIScrollView (Utils)

- (void)addContentWidth:(CGFloat)width
{
    CGSize contentSize = self.contentSize;
    self.contentSize = CGSizeMake(contentSize.width + width,
                                  contentSize.height);
}

- (void)addContentHeight:(CGFloat)height
{
    CGSize contentSize = self.contentSize;
    self.contentSize = CGSizeMake(contentSize.width,
                                  contentSize.height + height);
}

@end
