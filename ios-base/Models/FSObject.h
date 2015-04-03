//
//  IBObject.h
//

#import <Foundation/Foundation.h>

@interface FSObject : NSObject

@property (nonatomic, strong) id ID;

- (void)updateWithDictionary:(NSDictionary *)dictionary;

@end
