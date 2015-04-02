#import "NSCharacterSet+Utils.h"


#pragma mark -
@implementation NSCharacterSet (Utils)

- (NSArray *)arrayStringsFromCharacters
{
    NSMutableArray *array = [NSMutableArray array];
    for (int plane = 0; plane <= 16; plane++)
    {
        if ([self hasMemberInPlane:plane])
        {
            UTF32Char c;
            for (c = plane << 16; c < (plane+1) << 16; c++)
            {
                if ([self longCharacterIsMember:c])
                {
                    UTF32Char c1 = OSSwapHostToLittleInt32(c); // To make it byte-order safe
                    NSString *s = [[NSString alloc] initWithBytes:&c1 length:4 encoding:NSUTF32LittleEndianStringEncoding];
                    [array addObject:s];
                }
            }
        }
    }
    return [array copy];
}

@end
