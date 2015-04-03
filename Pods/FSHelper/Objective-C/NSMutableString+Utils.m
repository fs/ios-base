#import "NSMutableString+Utils.h"


#pragma mark -
@implementation NSMutableString (Utils)

- (void)replaceWithParametrs:(NSArray *)parametrs
{
    for (NSString *parametr in parametrs)
    {
        NSRange range               = [self rangeOfString:@"%@"];
        if (range.location != NSNotFound)
        {
            [self replaceCharactersInRange:range
                                withString:parametr];
        }
        else
        {
            break;
        }
    }
}

@end
