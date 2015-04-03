#import <Foundation/Foundation.h>


#pragma mark -
@interface NSArray (Utils)

- (id)objectAtIndexOrNil:(NSUInteger)index;

- (NSArray *)arrayByReverse;

@end


#pragma mark -
@interface NSArray (Random)

- (id)randomObject;
- (NSArray *)arrayByRandomReorder;
- (NSArray *)arrayByAddRandomObjectsFromArray:(NSArray *)array
                                        count:(NSUInteger)count;
- (NSArray *)arrayByRemoveRandomObjectsWithCount:(NSUInteger)count;


@end





