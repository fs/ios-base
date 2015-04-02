#import <Foundation/Foundation.h>


#pragma mark -
@interface NSObject (Selector)

- (id)performSelector:(SEL)selector
           withObject:(id)p1
           withObject:(id)p2
           withObject:(id)p3;
- (id)performSelector:(SEL)selector
           withObject:(id)p1
           withObject:(id)p2
           withObject:(id)p3
           withObject:(id)p4;

- (void)performSelectorInBackground:(SEL)selector
                         withObject:(id)p1
                         withObject:(id)p2;
- (void)performSelectorInBackground:(SEL)selector
                         withObject:(id)p1
                         withObject:(id)p2
                         withObject:(id)p3;
- (void)performSelectorInBackground:(SEL)selector
                         withObject:(id)p1
                         withObject:(id)p2
                         withObject:(id)p3
                         withObject:(id)p4;

@end
