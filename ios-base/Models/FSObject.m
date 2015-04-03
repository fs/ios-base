//
//  IBObject.m
//

#import "FSObject.h"

@implementation FSObject

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    
    self.ID     = dictionary[@"id"];
}

@end
