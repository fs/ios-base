#import "UIColor+Utils.h"


#pragma mark -
@implementation UIColor (Utils)

- (CGFloat)redValue
{
    const CGFloat *rgba = CGColorGetComponents(self.CGColor);
    return rgba[0];
}

- (CGFloat)greenValue
{
    const CGFloat *rgba = CGColorGetComponents(self.CGColor);
    return rgba[1];
}

- (CGFloat)blueValue
{
    const CGFloat *rgba = CGColorGetComponents(self.CGColor);
    return rgba[2];
}

- (CGFloat)alphaValue
{
    const CGFloat *rgba = CGColorGetComponents(self.CGColor);
    return rgba[3];
}

@end


#pragma mark -
@implementation UIColor (U255)

const CGFloat kMAX_RGB_COLOR_VALUE_FLOAT = 255.0f;

+ (UIColor *)colorWith255Red:(NSInteger)r
                       green:(NSInteger)g
                        blue:(NSInteger)b;
{
    return [self colorWith255Red:r
                           green:g
                            blue:b
                           alpha:kMAX_RGB_COLOR_VALUE_FLOAT];
}

+ (UIColor *)colorWith255Red:(NSInteger)r
                       green:(NSInteger)g
                        blue:(NSInteger)b
                       alpha:(NSInteger)a
{
    return [UIColor colorWithRed:r/kMAX_RGB_COLOR_VALUE_FLOAT
                           green:g/kMAX_RGB_COLOR_VALUE_FLOAT
                            blue:b/kMAX_RGB_COLOR_VALUE_FLOAT
                           alpha:a/kMAX_RGB_COLOR_VALUE_FLOAT];
}

@end



#pragma mark -
@implementation UIColor (Effects)

- (UIColor *)colorBrighterByPercent:(float)percent
{
    percent             = MAX(percent, 0.0f);
    percent             = (percent + 100.0f) / 100.0f;
    const CGFloat* rgba = CGColorGetComponents(self.CGColor);
    CGFloat red         = rgba[0];
    CGFloat green       = rgba[1];
    CGFloat blue        = rgba[2];
    CGFloat alpha       = rgba[3];
    CGFloat newR        = red * percent;
    CGFloat newG        = green * percent;
    CGFloat newB        = blue * percent;
    return [UIColor colorWithRed:newR
                           green:newG
                            blue:newB
                           alpha:alpha];
}

- (UIColor *)colorDarkerByPercent:(float)percent
{
    percent             = MAX(percent, 0.0f);
    percent             /= 100.0f;
    const CGFloat* rgba = CGColorGetComponents(self.CGColor);
    CGFloat r           = rgba[0];
    CGFloat g           = rgba[1];
    CGFloat b           = rgba[2];
    CGFloat a           = rgba[3];
    CGFloat newR        = r - (r * percent);
    CGFloat newG        = g - (g * percent);
    CGFloat newB        = b - (b * percent);
    return [UIColor colorWithRed:newR
                           green:newG
                            blue:newB
                           alpha:a];
}

@end
