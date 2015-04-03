#import <Foundation/Foundation.h>


#pragma mark -
@interface NSNumber (String)

- (NSString *)stringAsTruncateZeroValuesWithMaximumFractionDigits:(NSUInteger)number
                                                     roundingMode:(NSNumberFormatterRoundingMode)roundingMode;

@end
