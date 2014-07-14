
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

@property (nonatomic) CGSize  size;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

// works only when superview has been set
@property (nonatomic) CGFloat rightMarign;
@property (nonatomic) CGFloat bottomMarign;

- (void)removeAllSubviews;
- (void)addShineGradient;

@end

#pragma mark - UIScrollView+Utls

@interface UIScrollView (Utils)
@property (nonatomic) CGFloat contentWidth;
@property (nonatomic) CGFloat contentHeight;
@end

#pragma mark - UILabel+Utils

@interface UILabel (Utils)
- (UILabel *)deepCopy;
@end

#pragma mark - NSDictionary+Utils

@interface NSDictionary (Utils)
- (id)objectForKeyExcludeNSNull:(id)aKey;
- (NSString *)toCoreDataRequestString;
- (NSString *)toHttpRequestString;
@end

#pragma mark - NSArray+Utils

@interface NSArray (Utils)
- (id)objectAtIndexOrNil:(NSUInteger)index;
- (NSArray *)containNotObjects:(NSArray *)array;
- (NSArray *)shuffle;
@end

#pragma mark - NSString+Utils

@interface NSString (Utils)
- (NSURL*)toURL;
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
- (NSString *)lightURLEncodeString;
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
