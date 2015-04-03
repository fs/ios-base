#import "NSLocale+Utils.h"
#import "NSCharacterSet+Utils.h"


#pragma mark -
@implementation NSLocale (Utils)

+ (BOOL)is24timeHourFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString       = [formatter stringFromDate:[NSDate date]];
    NSRange amRange            = [dateString rangeOfString:[formatter AMSymbol]];
    NSRange pmRange            = [dateString rangeOfString:[formatter PMSymbol]];
    BOOL is24Hour              = amRange.location == NSNotFound && pmRange.location == NSNotFound;
    return is24Hour;
}

- (NSArray *)alphabet
{
    NSCharacterSet *charset    = [self objectForKey:NSLocaleExemplarCharacterSet];
    NSArray *chars             = [charset arrayStringsFromCharacters];
    NSMutableArray *alphabet   = [NSMutableArray new];
    for (NSUInteger i = 0; i < chars.count; i++)
    {
        unichar symbol             = [[chars[i] capitalizedString] characterAtIndex:0];
        NSValue *value             = [[NSValue alloc] initWithBytes:&symbol
                                                           objCType:@encode(unichar)];
        [alphabet addObject:value];
    }
    return [alphabet copy];
}

@end
