#import "UIStoryboard+Utils.h"


#pragma mark -
@implementation UIStoryboard (Utils)

+ (UIStoryboard *)main
{
    return [UIStoryboard storyboardWithName:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIMainStoryboardFile"]
                                     bundle:nil];
}

@end
