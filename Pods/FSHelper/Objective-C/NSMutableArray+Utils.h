#import <Foundation/Foundation.h>


#pragma mark -
@interface NSMutableArray (Utils)

- (void)reverse;

@end


#pragma mark -
@interface NSMutableArray (Random)

- (void)randomReorder;
- (void)addRandomObjectsFromArray:(NSArray *)array
                            count:(NSUInteger)count;
- (void)removeRandomObjectsWithCount:(NSUInteger)count;

@end


#pragma mark -
@interface NSMutableArray (Stack)

- (void)pushObject:(id)obj;
- (id)popObject;

- (void)unshiftObject:(id)obj;
- (id)shiftObject;

@end