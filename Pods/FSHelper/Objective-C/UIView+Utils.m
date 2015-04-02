#import "UIView+Utils.h"


#pragma mark -
@implementation UIView (Utils)

- (void)setVisible:(BOOL)visible
{
    self.hidden = !visible;
}

- (BOOL)visible
{
    return !self.hidden;
}

- (id)findFirstResponder
{
    if (self.isFirstResponder)
    {
        return self;
    }
    
    for (UIView *subView in self.subviews)
    {
        id responder = [subView findFirstResponder];
        if (responder) return responder;
    }
    
    return nil;
}

@end


#pragma mark -
@implementation UIView (UI)

- (void)UI_Rounded
{
    self.clipsToBounds      = YES;
    
    CALayer *layer          = self.layer;
    layer.cornerRadius      = self.width * 0.5f;
}

@end


#pragma mark -
@implementation UIView (Frame)

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    [self setFrame:frame];
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    [self setFrame:frame];
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    [self setFrame:frame];
}

- (void)setOriginX:(CGFloat)originX
{
    CGRect frame = self.frame;
    frame.origin.x = originX;
    [self setFrame:frame];
}

- (void)setOriginY:(CGFloat)originY
{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    [self setFrame:frame];
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    [self setFrame:frame];
}

@end


