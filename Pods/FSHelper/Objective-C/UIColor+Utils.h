#import <UIKit/UIKit.h>


#pragma mark -
@interface UIColor (Utils)

@property (nonatomic, readonly) CGFloat redValue;
@property (nonatomic, readonly) CGFloat greenValue;
@property (nonatomic, readonly) CGFloat blueValue;
@property (nonatomic, readonly) CGFloat alphaValue;

@end


#pragma mark -
@interface UIColor (U255)

+ (UIColor *)colorWith255Red:(NSInteger)r
                       green:(NSInteger)g
                        blue:(NSInteger)b;
+ (UIColor *)colorWith255Red:(NSInteger)r
                       green:(NSInteger)g
                        blue:(NSInteger)b
                       alpha:(NSInteger)a;

@end


#pragma mark -
@interface UIColor (Effects)

- (UIColor *)colorBrighterByPercent:(float)percent;
- (UIColor *)colorDarkerByPercent:(float)percent;

@end