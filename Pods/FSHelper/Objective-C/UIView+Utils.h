#import <UIKit/UIKit.h>


#pragma mark -
@interface UIView (Utils)

@property (nonatomic, assign) BOOL visible;

- (id)findFirstResponder;

@end


#pragma mark -
@interface UIView (UI)

- (void)UI_Rounded;

@end


#pragma mark -
@interface UIView (Frame)

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) CGPoint origin;

@end
