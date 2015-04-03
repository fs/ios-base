#import <Foundation/Foundation.h>


#pragma mark -
@interface NSMutableString (Utils)

/**
 @abstract passes through the line and consistently replaces %@ passed in the parameter string
 @example
 NSString *template  = @"Hello %@! You have %@ notification";
 [template replaceWithParametrs:@[@"Bob", @"5"]]
 @result
 template is @"Hello Bob! You have 5 notification"
 */
- (void)replaceWithParametrs:(NSArray *)parametrs;

@end