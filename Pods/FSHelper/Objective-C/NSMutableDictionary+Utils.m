#import "NSMutableDictionary+Utils.h"
#import "NSDictionary+Utils.h"


#pragma mark -
@implementation NSMutableDictionary (Utils)

- (void)renameKey:(NSString *)oldKey
            toKey:(NSString *)newKey
{
    [self setObject: [self objectForKey:oldKey] forKey:newKey];
    [self removeObjectForKey:oldKey];
}

@end
