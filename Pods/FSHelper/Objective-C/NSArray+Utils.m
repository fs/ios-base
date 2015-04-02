#import "NSArray+Utils.h"
#import "NSMutableArray+Utils.h"


#pragma mark -
@implementation NSArray (Utils)

- (id)objectAtIndexOrNil:(NSUInteger)index
{
    if (index < self.count)
    {
        return [self objectAtIndex:index];
    }
    
    return nil;
}

- (NSArray *)arrayByReverse
{
    NSMutableArray *newArray                = [self mutableCopy];
    [newArray reverse];
    return [newArray copy];
}

@end


#pragma mark -
@implementation NSArray (Random)

- (id)randomObject
{
    NSUInteger count    = [self count];
    if (count == 0)
    {
        return nil;
    }
    NSUInteger n        = arc4random() % count;
    return [self objectAtIndex:n];
}

- (NSArray *)arrayByRandomReorder
{
    NSMutableArray *randomOrderArray        = [self mutableCopy];
    [randomOrderArray randomReorder];
    return [randomOrderArray copy];
}

- (NSArray *)arrayByAddRandomObjectsFromArray:(NSArray *)array
                                        count:(NSUInteger)count
{
    NSMutableArray *newArray                = [self mutableCopy];
    [newArray addRandomObjectsFromArray:array
                                  count:count];
    
    return [newArray copy];
}

- (NSArray *)arrayByRemoveRandomObjectsWithCount:(NSUInteger)count
{
    NSMutableArray *newArray                = [self mutableCopy];
    [newArray removeRandomObjectsWithCount:count];
    
    return [newArray copy];
}

@end


