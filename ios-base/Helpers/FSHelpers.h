#import <UIKit/UIKit.h>
#import "Macros.h"
#import "NSDate+Extensions.h"
#import "UIImage+Utils.h"
#import "UIImage+ImageEffects.h"
//if you have SDWebImage added to project - you can use helper for
//uploading, caching and setting images to UIImageView
//You just need to uncomment next line
//#define SDWebImage
#import "UIImageView+Utils.h"


static inline void dispatch_after_short(CGFloat delay, dispatch_block_t block){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
};

#pragma mark - UIView+Utils

@interface UIView (Utils)
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)rightX;
- (CGFloat)bottomY;

- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width;
- (void)setOriginX:(CGFloat)originX;
- (void)setOriginY:(CGFloat)originY;
- (void)moveTo:(CGPoint)position;

- (void)removeAllSubviews;

- (void) addBottomLine;
- (void) addTopLine;

// negative value to remove height/width
- (void)addHeight:(CGFloat)height;
- (void)addWidth:(CGFloat)width;
// negative value to move up
-(void) addOriginX:(CGFloat)originX;
-(void) addOriginY:(CGFloat)originY;
- (void)setOrigin:(CGPoint)position ;
// Layout views
- (CGSize)prefferedSize;

- (void)layoutAllSubviewsVertically;
- (void)layoutAllSubviewsVerticallyFromBottom;

-(void) addGradient;
- (BOOL)findAndResignFirstResponder;

-(void) resizeWithLabel:(UILabel*)label;
- (NSMutableArray*) allSubViews;
- (NSMutableArray*)allLabelsButtonsAndTextFields;
- (NSMutableArray*)allViewsWithAccessibilityLabel:(NSString*)label;
@end

#pragma mark - UIScrollView+Utls

@interface UIScrollView (Utils)
- (void)addContentWidth:(CGFloat)width;
- (void)addContentHeight:(CGFloat)height;
@end

#pragma mark - UILabel+Utils

@interface UILabel (Utils)
+ (UILabel*)labelWithText:(NSString*) text;
- (UILabel*)makeCopyWithFontSize:(CGFloat) fontSize;

- (CGSize)prefferedSize;
- (CGFloat)preferredWidth;
- (CGFloat)preferredHeight;
- (void)stretchToPrefferedWidth;
- (void)stretchToPrefferedHeight;

-(void) resizeToFit;
-(void) resizeVerticallyToFit;
-(void) setTextWithAutoFit:(NSString*) text;
-(void) highlightTextWithRange:(NSRange)range;
@end

#pragma mark - NSDictionary+Utils

@interface NSDictionary (Utils)

- (id)objectForKeyOrDefault:(id)aKey aDefault:(id)aDefault;
- (id)objectForKeyOrEmptyString:(id)aKey;
- (id)objectForKeyOrNil:(id)aKey;
- (NSInteger)intForKeyOrDefault:(id)aKey aDefault:(NSInteger)aDefault;
- (BOOL)boolForKeyOrDefault:(id)aKey aDefault:(BOOL)aDefault;
- (id)objectForInt:(NSInteger)anInt;
- (NSString *)toCoreDataRequestString;
- (NSString *)toHttpRequestString;

@end

#pragma mark - NSMutableDictionary+Utils

@interface NSMutableDictionary (Utils)
- (void)setArrayOrEmptyString:(NSArray*)array forKey:(id)aKey;
- (void)setObjectIfNotNil:(id)anObject forKey:(id)aKey;
- (void)trimValues;

@end

#pragma mark - NSArray+Utils

@interface NSArray (WRK)
- (id) objectAtIndexOrNil:(int)index;
- (NSArray *)containNotObjects:(NSArray *)array;

@end

#pragma mark - NSString+Utils

@interface NSString (Utils)
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
- (NSString *)LightURLEncodeString;
+ (BOOL)emailValidate:(NSString *)email;
- (CGSize)sizeForStringWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
@end

#pragma mark - NSObject+Utils

@interface NSObject (Utils)

- (BOOL)isEmpty;

@end

#pragma mark - UITableView+Utils

@interface UITableView (Utils)
- (void)deselectSelectedRow;
@end





