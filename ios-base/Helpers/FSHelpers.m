#import "FSHelpers.h"
#import <QuartzCore/QuartzCore.h>

#pragma mark - UIView+Utils

@implementation UIView (Utils)

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

-(CGFloat)rightX{
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)bottomY{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    [self setFrame:frame];
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    [self setFrame:frame];
}

-(void) setOriginX:(CGFloat)originX{
    CGRect frame = self.frame;
    frame.origin.x = originX;
    [self setFrame:frame];
}

-(void) setOriginY:(CGFloat)originY{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    [self setFrame:frame];
}

- (void)moveTo:(CGPoint)position {
    CGRect frame = self.frame;
    frame.origin = position;
    [self setFrame:frame];
}

- (void)removeAllSubviews {
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
}

-(void)addBottomLine{
    CGRect frame = {{0, self.height - ONE_PIXEL}, {self.width, ONE_PIXEL}};
    UIView *v = [[UIView alloc] initWithFrame:frame];
    v.backgroundColor = RGB(200,200, 200);
    [self addSubview:v];
    //v.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
}

-(void)addTopLine{
    CGRect frame = {{0, 0}, {self.width, ONE_PIXEL}};
    UIView *v = [[UIView alloc] initWithFrame: frame];
    v.backgroundColor = RGB(200,200, 200);
    [self addSubview:v];
    //v.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
}


- (void)addHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = frame.size.height+ height;
    [self setFrame:frame];
}
- (void)addWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = frame.size.width + width;
    [self setFrame:frame];
}

-(void) addOriginX:(CGFloat)originX{
    CGRect frame = self.frame;
    frame.origin.x = frame.origin.x + originX;
    [self setFrame:frame];
}
-(void) addOriginY:(CGFloat)originY{
    CGRect frame = self.frame;
    frame.origin.y = frame.origin.y + originY;
    [self setFrame:frame];
}

- (void)setOrigin:(CGPoint)position {
    CGRect frame = self.frame;
    frame.origin = position;
    [self setFrame:frame];
}

- (CGSize)prefferedSize {
    return self.frame.size;
}

- (void)layoutAllSubviewsVertically {
    CGFloat totalHeight = 0.0f;
    for (UIView *view in self.subviews) {
        if (![view isKindOfClass:[UIImageView class]] && !view.isHidden) {
            CGSize prefferedSize = [view prefferedSize];
            [view setHeight:prefferedSize.height];
            [view setWidth:self.width];
            [view moveTo:CGPointMake(0.0f, totalHeight)];
            
            totalHeight += prefferedSize.height;
        }
    }
    CGFloat heightToSet = totalHeight;
    [self setHeight:heightToSet];
}

- (void)layoutAllSubviewsVerticallyFromBottom {
    CGFloat totalHeight = [self height];
    for (UIView *view in self.subviews) {
        if (!view.isHidden) {
            CGSize prefferedSize = [view prefferedSize];
            [view setHeight:prefferedSize.height];
            [view setWidth:self.width];
            
            totalHeight -= prefferedSize.height;
            [view moveTo:CGPointMake(0.0f, totalHeight)];
        }
    }
}

-(void) addGradient{
        
        // Add Border
        CALayer *layer = self.layer;
        layer.cornerRadius = 10.0f;
        layer.masksToBounds = YES;
        layer.borderWidth = 1.0f;
        layer.borderColor = [UIColor colorWithWhite:0.5f alpha:0.2f].CGColor;
        
        // Add Shine
        CAGradientLayer *shineLayer = [CAGradientLayer layer];
        shineLayer.frame = layer.bounds;
        shineLayer.colors = [NSArray arrayWithObjects:
                             (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                             (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                             (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                             (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                             (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                             nil];
        shineLayer.locations = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:0.0f],
                                [NSNumber numberWithFloat:0.5f],
                                [NSNumber numberWithFloat:0.5f],
                                [NSNumber numberWithFloat:0.8f],
                                [NSNumber numberWithFloat:1.0f],
                                nil];
        [layer addSublayer:shineLayer];
}

- (BOOL)findAndResignFirstResponder
{
    if (self.isFirstResponder) {
        [self resignFirstResponder];
        NSLog(@"first responder was: %@",self);
        return YES;
    }
    for (UIView *subView in self.subviews) {
        if ([subView findAndResignFirstResponder])
            return YES;
    }
    return NO;
}

-(void) resizeWithLabel:(UILabel*)label{
    CGSize size=  [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(300, 30)];
    CGPoint center = self.center;
    self.width = size.width+16;
    self.center = center;
}

- (NSMutableArray*)allSubViews{
    NSMutableArray *arr= [NSMutableArray array];
    [arr addObject:self];
    for (UIView *subview in self.subviews){
        [arr addObjectsFromArray:(NSArray*)[subview allSubViews]];
    }
    return arr;
}

- (NSMutableArray*)allLabelsButtonsAndTextFields{
    NSMutableArray *arr= [NSMutableArray array];
    if ([self isKindOfClass:[UILabel class]] || [self isKindOfClass:[UIButton class]] || [self isKindOfClass:[UITextField class]])
        [arr addObject:self];
    else
        for (UIView *subview in self.subviews)    {
            [arr addObjectsFromArray:(NSArray*)[subview allLabelsButtonsAndTextFields]];
        }
    return arr;
}

- (NSMutableArray*)allViewsWithAccessibilityLabel:(NSString*)label{
    NSMutableArray *arr= [NSMutableArray array];
    if ([[self accessibilityLabel] isEqualToString:label])
        [arr addObject:self];
    for (UIView *subview in self.subviews) {
        [arr addObjectsFromArray:(NSArray*)[subview allViewsWithAccessibilityLabel:label]];
    }
    return arr;
}

@end

#pragma mark - UILabel+Utils

@implementation UILabel (Utils)

+(UILabel*) labelWithText:(NSString*) text{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0f]];
    [label setShadowColor:[UIColor whiteColor]];
    [label setShadowOffset:CGSizeMake(0, 1)];
    [label setText:text];
    [label resizeToFit];
    [label setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth];
    [label setTextAlignment:NSTextAlignmentCenter];
    return label;
}

-(UILabel*) makeCopyWithFontSize:(CGFloat) fontSize{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:self.font.familyName size:fontSize];
    label.backgroundColor = self.backgroundColor;
    label.text = self.text;
    label.frame = self.frame;
    label.textColor = self.textColor;
    label.shadowColor = self.shadowColor;
    label.shadowOffset = self.shadowOffset;
    label.textAlignment = self.textAlignment;
    return label;
}

- (CGSize)prefferedSize {
    return CGSizeMake(self.width, [self preferredHeight]);
}

- (CGFloat)preferredWidth {
    CGRect frame = CGRectMake(0, 0, 0, self.frame.size.height);
    UILabel *testLabel = [[UILabel alloc] initWithFrame:frame];
    testLabel.text = self.text;
    testLabel.font = self.font;
    testLabel.textAlignment = self.textAlignment;
    testLabel.lineBreakMode = self.lineBreakMode;
    testLabel.numberOfLines = 0;
    [testLabel sizeToFit];
    CGFloat result = testLabel.frame.size.width;
    return result;
}

- (CGFloat)preferredHeight {
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, 0);
    UILabel *testLabel = [[UILabel alloc] initWithFrame:frame];
    testLabel.text = self.text;
    testLabel.font = self.font;
    testLabel.textAlignment = self.textAlignment;
    testLabel.lineBreakMode = self.lineBreakMode;
    testLabel.numberOfLines = 0;
    [testLabel sizeToFit];
    CGFloat preferredCellHeight = testLabel.frame.size.height;
    return preferredCellHeight;
}

- (void)stretchToPrefferedWidth {
    CGRect frame = self.frame;
    frame.size.width = [self preferredWidth] + 3.0f;
    self.frame = frame;
}

- (void)stretchToPrefferedHeight {
    CGRect frame = self.frame;
    frame.size.height = [self preferredHeight];
    self.frame = frame;
}

-(void) resizeToFit{
    CGSize expectedLabelSize = [self.text sizeWithFont:self.font
                                     constrainedToSize:CGSizeMake(10000, self.frame.size.height)];
    
    //adjust the label the the new height.
    CGRect newFrame = self.frame;
    newFrame.size = expectedLabelSize;
    newFrame.size.height = ceilf(self.frame.size.height);
    self.frame = newFrame;
}

-(void) resizeVerticallyToFit{
    self.numberOfLines = 0;
    CGSize expectedLabelSize = [self.text sizeWithFont:self.font
                                     constrainedToSize:CGSizeMake(self.width, 10000)];
    //adjust the label the the new height.
    CGRect newFrame = self.frame;
    newFrame.size = expectedLabelSize;
    newFrame.size.width = ceilf(self.frame.size.width);
    self.frame = newFrame;
}

-(void) setTextWithAutoFit:(NSString*) text{
    self.text = text;
    CGSize expectedLabelSize = [text sizeWithFont:self.font
                                constrainedToSize:CGSizeMake(10000, self.frame.size.height)];
    
    //adjust the label the the new height.
    CGRect newFrame = self.frame;
    newFrame.size = expectedLabelSize;
    newFrame.size.height = self.frame.size.height;
    self.frame = newFrame;
    //   self.backgroundColor = [UIColor greenColor]; // for debugging
}

-(void)highlightTextWithRange:(NSRange)range{
    if ([self respondsToSelector:@selector(setAttributedText:)]){
        
        UIFont *boldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0f];
        UIFont *regularFont = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
        // Create the attributes
        NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               regularFont, NSFontAttributeName,
                               nil];
        NSDictionary *attrsBold = [NSDictionary dictionaryWithObjectsAndKeys:
                                   boldFont, NSFontAttributeName,
                                   nil];
        
        // Create the attributed string (text + attributes)
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:self.text
                                               attributes:attrs];
        [attributedText setAttributes:attrsBold range:range];
        
        // Set it in our UILabel and we are done!
        [self setAttributedText:attributedText];
    }
}

@end

#pragma mark - NSDictionary+Utils

@implementation NSDictionary (Utils)

- (id)objectForKeyOrDefault:(id)aKey aDefault:(id)aDefault {
    id obj = [self objectForKey:aKey];
    return (! obj || obj == [NSNull null]) ? aDefault : obj;
}

- (id)objectForKeyOrEmptyString:(id)aKey {
    return [self objectForKeyOrDefault:aKey aDefault:@""];
}

- (id)objectForKeyOrNil:(id)aKey {
    return [self objectForKeyOrDefault:aKey aDefault:nil];
}

- (NSInteger)intForKeyOrDefault:(id)aKey aDefault:(NSInteger)aDefault {
    id object = [self objectForKeyOrDefault:aKey aDefault:nil];
    if (object) {
        if ([object respondsToSelector:@selector(intValue)]) {
            return [object intValue];
        }
    }
    return aDefault;
}

- (BOOL)boolForKeyOrDefault:(id)aKey aDefault:(BOOL)aDefault {
    id object = [self objectForKeyOrDefault:aKey aDefault:nil];
    if (object) {
        if ([object respondsToSelector:@selector(boolValue)]) {
            return [object boolValue];
        }
    }
    return aDefault;
}

- (id)objectForInt:(NSInteger)anInt {
    return [self objectForKey:[NSNumber numberWithInteger:anInt]];
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

#pragma mark - NSMutableDictionary+Utils

@implementation NSMutableDictionary (Utils)
- (void)setArrayOrEmptyString:(NSArray*)array forKey:(id)aKey{
    if ([array isKindOfClass:[NSArray class]] && array.count>0) {
        [self setObject:array forKey:aKey];
    } else {
        [self setObject:@"" forKey:aKey];
    }
}

- (void)setObjectIfNotNil:(id)anObject forKey:(id)aKey {
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    }
}

- (void)trimValues {
    NSArray *allKeys = [NSArray arrayWithArray:[self allKeys]];
    for (id key in allKeys) {
        id object = [self objectForKey:key];
        if ([object isKindOfClass:[NSString class]]) {
            NSString *value = (NSString *)object;
            NSString *trimmedString = [value stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [self setObject:trimmedString forKey:key];
        }
    }
}

@end

#pragma mark - NSArray+Utils

@implementation NSArray (Utils)

- (id) objectAtIndexOrNil:(int)index{
    if (index<self.count && index>=0)
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

@end

#pragma mark - NSString+Utils

@implementation NSString (Utils)

- (NSString *)URLEncodedString {
	NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self,
                                                                                                     NULL, (CFStringRef)@"!*'();@&=+$,?%#[]",
                                                                                                     kCFStringEncodingUTF8));
	return encodedString;
}

- (NSString *)URLDecodedString {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)LightURLEncodeString {
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
        CGSize contentSize = [self sizeWithFont:font
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
