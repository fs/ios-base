#import "NSNumber+Utils.h"


#pragma mark -
@implementation NSNumber (String)

- (NSString *)stringAsTruncateZeroValuesWithMaximumFractionDigits:(NSUInteger)number
                                                     roundingMode:(NSNumberFormatterRoundingMode)roundingMode
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:number];
    [formatter setMinimumIntegerDigits:1];
    [formatter setRoundingMode:roundingMode];
    return [formatter stringFromNumber:self];
}

@end
