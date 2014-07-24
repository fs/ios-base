//
//  KeysManager.h
//  ios-base
//
//  Created by Kruperfone on 24.07.14.
//  Copyright (c) 2014 FlatStack. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PRIVATE_KEY @"PRIVATE"
#define PUBLIC_KEY @"PUBLIC"
#define BASE_URL_KEY @"BASE_URL"
#define API_KEY @"API_KEY"

#define TZ_API @"TZ_API"
#define SOCIAL_FAMILY @"Social family"

@interface KeysManager : NSObject

/*! \returns The dictionary with all keys or nil if file is not found
 */
+(NSDictionary *) getKeychan;

/*! \param keysFamily The family of keys
 * \returns The dictionary for keys family or nil if family is not exist
 */
+(NSDictionary *) getKeysFamily:(NSString *)keysFamily;

@end