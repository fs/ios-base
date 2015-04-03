#import "NSObject+Utils.h"


#pragma mark -
@implementation NSObject (Utils)

- (id)performSelector:(SEL)selector
           withObject:(id)p1
           withObject:(id)p2
           withObject:(id)p3
{
    NSMethodSignature *sig = [self methodSignatureForSelector:selector];
    if (sig)
    {
        NSInvocation *invo     = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:selector];
        [invo setArgument:&p1
                  atIndex:2];
        [invo setArgument:&p2
                  atIndex:3];
        [invo setArgument:&p3
                  atIndex:4];
        [invo invoke];
        if (sig.methodReturnLength)
        {
            id anObject;
            [invo getReturnValue:&anObject];
            return anObject;
        }
        else
        {
            return nil;
        }
    }
    else
    {
        return nil;
    }
}

- (id)performSelector:(SEL)selector
           withObject:(id)p1
           withObject:(id)p2
           withObject:(id)p3
           withObject:(id)p4
{
    NSMethodSignature *sig = [self methodSignatureForSelector:selector];
    if (sig)
    {
        NSInvocation* invo     = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:selector];
        [invo setArgument:&p1
                  atIndex:2];
        [invo setArgument:&p2
                  atIndex:3];
        [invo setArgument:&p3
                  atIndex:4];
        [invo setArgument:&p4
                  atIndex:5];
        [invo invoke];
        if (sig.methodReturnLength)
        {
            id anObject;
            [invo getReturnValue:&anObject];
            return anObject;
        }
        else
        {
            return nil;
        }
    }
    else
    {
        return nil;
    }
}

- (void)performSelectorInBackground:(SEL)selector
                         withObject:(id)p1
                         withObject:(id)p2
{
    NSMethodSignature *sig = [self methodSignatureForSelector:selector];
    if (sig)
    {
        NSInvocation *invo     = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:selector];
        [invo setArgument:&p1 atIndex:2];
        [invo setArgument:&p2 atIndex:3];
        [invo retainArguments];
        [invo performSelectorInBackground:@selector(invoke)
                               withObject:nil];
    }
}

- (void)performSelectorInBackground:(SEL)selector
                         withObject:(id)p1
                         withObject:(id)p2
                         withObject:(id)p3
{
    NSMethodSignature *sig = [self methodSignatureForSelector:selector];
    if (sig)
    {
        NSInvocation *invo     = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:selector];
        [invo setArgument:&p1
                  atIndex:2];
        [invo setArgument:&p2
                  atIndex:3];
        [invo setArgument:&p3
                  atIndex:4];
        [invo retainArguments];
        [invo performSelectorInBackground:@selector(invoke)
                               withObject:nil];
    }
}

- (void)performSelectorInBackground:(SEL)selector
                         withObject:(id)p1
                         withObject:(id)p2
                         withObject:(id)p3
                         withObject:(id)p4
{
    NSMethodSignature *sig = [self methodSignatureForSelector:selector];
    if (sig)
    {
        NSInvocation *invo     = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:selector];
        [invo setArgument:&p1
                  atIndex:2];
        [invo setArgument:&p2
                  atIndex:3];
        [invo setArgument:&p3
                  atIndex:4];
        [invo setArgument:&p4
                  atIndex:5];
        [invo retainArguments];
        [invo performSelectorInBackground:@selector(invoke)
                               withObject:nil];
    }
}

@end


