#import "NSMutableArray+Utils.h"
#import "NSArray+Utils.h"


#pragma mark -
@implementation NSMutableArray (Utils)

- (void)reverse
{
    for (NSInteger i = 0, j = self.count - 1; i < j; ++i, --j)
    {
        [self exchangeObjectAtIndex:i
                  withObjectAtIndex:j];
    }
}

@end


#pragma mark -
@implementation NSMutableArray (Random)

- (void)randomReorder
{
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i)
    {
        // Select a random element between i and end of array to swap with.
        NSUInteger nElements = count - i;
        NSUInteger n = (arc4random() % nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

- (void)addRandomObjectsFromArray:(NSArray *)array
                            count:(NSUInteger)count
{
    if (!array || count == 0)
        return;
    
    for (NSUInteger i = 0; i < count; i++)
    {
        id object   = [array randomObject];
        [self addObject:object];
    }
}

- (void)removeRandomObjectsWithCount:(NSUInteger)count
{
    if (count == 0)
        return;
    
    count               = MAX(count, [self count]);
    for (NSUInteger i = 0; i < count; i++)
    {
        [self removeObject:[self randomObject]];
    }
}

@end


#pragma mark -
@implementation NSMutableArray (STACK)

- (void)pushObject:(id)obj
{
    [self addObject:obj];
}

- (id)popObject
{
    id pop = [self lastObject];
    if (pop)
    {
        [self removeLastObject];
    }
    return pop;
}

- (void)unshiftObject:(id)obj
{
    [self insertObject:obj
               atIndex:0];
}

- (id)shiftObject
{
    id shift = [self firstObject];
    if (shift)
    {
        [self removeObjectAtIndex:0];
    }
    return shift;
}

@end


