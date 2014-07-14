
#import "FSHelpers.h"
#import <QuartzCore/QuartzCore.h>

#pragma mark - UIView+Utils

@interface UIGradientView : UIView
@property (nonatomic,readonly,retain) CAGradientLayer  *layer;
@end

@implementation UIGradientView
+ (Class)layerClass {
    return [CAGradientLayer class];
}
@end

@implementation UIView (Utils)

#pragma mark - Frame Setters/Getters
- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    [self setFrame:frame];
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    [self setFrame:frame];
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    [self setFrame:frame];
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    [self setFrame:frame];
}

- (CGFloat)rightMarign {
    return self.superview.bounds.size.width - CGRectGetMaxX(self.frame);
}

- (void)setRightMarign:(CGFloat)rightMarign {
    self.x = self.superview.bounds.size.width - rightMarign - self.frame.size.width;
}

- (CGFloat)bottomMarign {
    return self.superview.bounds.size.height - CGRectGetMaxY(self.frame);
}

- (void)setBottomMarign:(CGFloat)bottomMarign {
    self.y = self.superview.bounds.size.height - bottomMarign - self.frame.size.height;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)position {
    CGRect frame = self.frame;
    frame.origin = position;
    [self setFrame:frame];
}

- (CGSize)size {
    return self.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    [self setFrame:frame];
}

#pragma mark -

- (void)removeAllSubviews {
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
}

- (void)addShineGradient{
    UIGradientView *newSubview = [[UIGradientView alloc] initWithFrame:self.bounds];
    newSubview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    newSubview.layer.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         nil];
    newSubview.layer.locations = @[@0.0f, @0.5f, @0.5f, @0.8f, @1.0f];
    [self addSubview:newSubview];
}

@end

#pragma mark - UIScrollView+Utls

@implementation UIScrollView (Utils)
- (CGFloat)contentWidth {
    return self.contentSize.width;
}
- (void)setContentWidth:(CGFloat)contentWidth {
    self.contentSize = CGSizeMake(contentWidth, self.contentSize.height);
}

- (CGFloat)contentHeight {
    return self.contentSize.height;
}
- (void)setContentHeight:(CGFloat)contentHeight {
    self.contentSize = CGSizeMake(self.contentSize.width, contentHeight);
}
@end

#pragma mark - UILabel+Utils

@implementation UILabel (Utils)

- (UILabel*)deepCopy {
    UILabel *label = [[UILabel alloc] init];
    label.font = self.font;
    label.backgroundColor = self.backgroundColor;
    label.text = self.text;
    label.frame = self.frame;
    label.textColor = self.textColor;
    label.shadowColor = self.shadowColor;
    label.shadowOffset = self.shadowOffset;
    label.textAlignment = self.textAlignment;
    return label;
}

@end

#pragma mark - NSDictionary+Utils

@implementation NSDictionary (Utils)

- (id)objectForKeyExcludeNSNull:(id)aKey {
    id obj = [self objectForKey:aKey];
    return ([obj isKindOfClass:[NSNull class]]) ? nil : obj;
}

- (NSString *)toHttpRequestString {
    NSMutableArray *arrayOfPairs = [NSMutableArray arrayWithCapacity:[self allKeys].count];
    for (NSString *key in [self allKeys]) {
        NSString *value = [self valueForKey:key];
        NSString *pair = [NSString stringWithFormat:@"%@=%@", key, value];
        [arrayOfPairs addObject:pair];
    }
    NSString *toReturn = [arrayOfPairs componentsJoinedByString:@"&"];
    return toReturn;
}

- (NSString *)toCoreDataRequestString {
    NSString *toReturn = @"(YES == YES)";
    for (NSString *key in [self allKeys]) {
        NSString *value = [self valueForKey:key];
        NSString *pair = [NSString stringWithFormat:@" AND (%@ == %@)", key, value];
        toReturn = [toReturn stringByAppendingString:pair];
    }
    return toReturn;
}

@end

#pragma mark - NSArray+Utils

@implementation NSArray (Utils)

- (id)objectAtIndexOrNil:(NSUInteger)index{
    if (index < self.count)
        return [self objectAtIndex:index];
    return nil;
}

- (NSArray *)containNotObjects:(NSArray *)array
{
    NSMutableArray *result = [NSMutableArray new];
    for (id object in array) {
        if (![self containsObject:object]) {
            [result addObject:object];
        }
    }
    return result;
}

- (NSArray *)shuffle
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    NSUInteger count = [array count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform(remainingCount);
        [array exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    return [NSArray arrayWithArray:array];
}

@end

#pragma mark - NSString+Utils

@implementation NSString (Utils)

- (NSURL*)toURL {
    return [NSURL URLWithString:self];
}

- (NSString *)URLEncodedString {
	NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self,
                                                                                                     NULL, (CFStringRef)@"!*'();@&=+$,?%#[]",
                                                                                                     kCFStringEncodingUTF8));
	return encodedString;
}

- (NSString *)URLDecodedString {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)lightURLEncodeString {
    NSMutableString *tempStr = [NSMutableString stringWithString:self];
    [tempStr replaceOccurrencesOfString:@" " withString:@"+" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [tempStr length])];
    return [[NSString stringWithFormat:@"%@",tempStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (BOOL)emailValidate:(NSString *)email {
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:email];
}

- (CGSize)sizeForStringWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGSize contentSize;
    if (IS_IOS_7) {
        CGSize boundingSize = {size.width - 10, MAXFLOAT};
        // I substract 10 because boundingRect can't fit whole text
        // http://stackoverflow.com/a/19163784/1199418
        CGRect contentRect = [self boundingRectWithSize:boundingSize
                                                options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                             attributes:@{NSFontAttributeName:font}
                                                context:NULL];
        contentSize = CGSizeMake(size.width, ceilf(contentRect.size.height));
    } else {
        contentSize = [self sizeWithFont:font
                              constrainedToSize:CGSizeMake(size.width, MAXFLOAT)];
        contentSize = CGSizeMake(size.width, ceilf(contentSize.height));
    }
    return contentSize;
}

@end

#pragma mark - NSObject+Utils

@implementation NSObject (Utils)

- (BOOL)isEmpty {
    return self == nil
    || ([self respondsToSelector:@selector(length)]
        && [(NSData *)self length] == 0)
    || ([self respondsToSelector:@selector(count)]
        && [(NSArray *)self count] == 0)
    || ([self respondsToSelector:@selector(isEqualToString:)]
        && [(NSString *)self isEqualToString:@""]);
}

@end

#pragma mark - UiTableView+Utils

@implementation UITableView (Utils)

- (void)deselectSelectedRow {
    if (self.indexPathForSelectedRow) {
        [self deselectRowAtIndexPath:self.indexPathForSelectedRow animated:YES];
    }
}

@end
