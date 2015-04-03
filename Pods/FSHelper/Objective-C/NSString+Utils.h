#import "NSMutableString+Utils.h"


#pragma mark -
@interface NSString (Utils)

/**
 @abstract passes through the line and consistently replaces %@ passed in the parameter string
 @example
 NSString *template  = @"Hello %@! You have %@ notification";
 NSString *result    = [template replaceWithParametrs:@[@"Bob", @"5"]]
 @result
 template is @"Hello Bob! You have 5 notification"
 */
- (NSString *)stringByReplaceWithParametrs:(NSArray *)parametrs;

@end


#pragma mark -
@interface NSString (Escapes)

/**
 @example
 NSString *result = [@"Is You ready?" stringByAddingCustomPercentEscapesWithCharacters:@"!*'();:@&=+$,/?%#[]"];
 */

- (NSString *)stringByAddingCustomPercentEscapesWithCharacters:(NSString *)symbols;

@end


#pragma mark -
@interface NSString (Random)

+ (NSString *)randomStringWithLength:(NSUInteger)length;

@end








