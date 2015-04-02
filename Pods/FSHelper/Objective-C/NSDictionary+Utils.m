#import "NSDictionary+Utils.h"
#import "NSMutableDictionary+Utils.h"


#pragma mark -
@implementation NSDictionary (Utils)

- (id)objectForKey:(id)aKey
      defaultValue:(id)aDefault
{
    id obj = [self objectForKey:aKey];
    
    return (!obj || [obj isEqual:[NSNull null]]) ? aDefault : obj;
}

- (id)objectForKeyOrEmptyString:(id)aKey
{
    return [self objectForKey:aKey
                 defaultValue:@""];
}

- (id)objectForKeyOrNil:(id)aKey
{
    return [self objectForKey:aKey
                 defaultValue:nil];
}

- (NSInteger)integerForKey:(id)aKey
              defaultValue:(NSInteger)aDefault
{
    id object = [self objectForKey:aKey
                      defaultValue:nil];
    if (object)
    {
        if ([object respondsToSelector:@selector(integerValue)])
        {
            return [object integerValue];
        }
    }
    return aDefault;
}

- (NSUInteger)unsignedIntegerForKey:(id)aKey
                       defaultValue:(NSUInteger)aDefault
{
    id object = [self objectForKey:aKey
                      defaultValue:nil];
    if (object)
    {
        if ([object respondsToSelector:@selector(unsignedIntegerValue)])
        {
            return [object unsignedIntegerValue];
        }
    }
    return aDefault;
}

- (CGFloat)floatForKey:(id)aKey
          defaultValue:(CGFloat)aDefault
{
    id object = [self objectForKey:aKey
                      defaultValue:nil];
    if (object)
    {
        if ([object respondsToSelector:@selector(floatValue)])
        {
            return [object floatValue];
        }
    }
    return aDefault;
}

- (BOOL)boolForKey:(id)aKey
      defaultValue:(BOOL)aDefault
{
    id object = [self objectForKey:aKey
                      defaultValue:nil];
    if (object)
    {
        if ([object respondsToSelector:@selector(boolValue)])
        {
            return [object boolValue];
        }
    }
    return aDefault;
}

@end


#pragma mark -
@implementation NSDictionary (JSON)

- (NSData *)toJSON
{
    NSData *data =
    [NSJSONSerialization dataWithJSONObject:self
                                    options:NSJSONWritingPrettyPrinted
                                      error:nil];
    return data;
}

- (NSString *)jsonFormat
{
    return [[NSString alloc] initWithData:[self toJSON]
                                 encoding:NSUTF8StringEncoding];
}

@end


#pragma mark -
@implementation NSDictionary (HTTP)

- (NSString *)toGETRequest
{
    NSMutableArray *arrayOfPairs = [NSMutableArray arrayWithCapacity:self.count];
    for (NSString *key in [self allKeys])
    {
        NSString *value = [self valueForKey:key];
        NSString *pair = [NSString stringWithFormat:@"%@=%@", key, value];
        [arrayOfPairs addObject:pair];
    }
    NSString *result = [arrayOfPairs componentsJoinedByString:@"&"];
    return result;
}

@end