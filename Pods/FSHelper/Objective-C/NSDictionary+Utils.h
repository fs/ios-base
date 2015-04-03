#import <UIKit/UIKit.h>


#pragma mark -
@interface NSDictionary (Utils)

- (id)objectForKey:(id)aKey
      defaultValue:(id)aDefault;
- (id)objectForKeyOrEmptyString:(id)aKey;
- (id)objectForKeyOrNil:(id)aKey;

- (NSInteger)integerForKey:(id)aKey
              defaultValue:(NSInteger)aDefault;
- (NSUInteger)unsignedIntegerForKey:(id)aKey
                       defaultValue:(NSUInteger)aDefault;
- (CGFloat)floatForKey:(id)aKey
          defaultValue:(CGFloat)aDefault;
- (BOOL)boolForKey:(id)aKey
      defaultValue:(BOOL)aDefault;

@end


#pragma mark -
@interface NSDictionary (JSON)

- (NSData *)toJSON;
- (NSString *)jsonFormat;

@end


#pragma mark -
@interface NSDictionary (HTTP)

- (NSString *)toGETRequest;

@end
