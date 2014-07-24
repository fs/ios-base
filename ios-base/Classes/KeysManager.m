//
//  KeysManager.m
//  ios-base
//
//  Created by Kruperfone on 24.07.14.
//  Copyright (c) 2014 FlatStack. All rights reserved.
//

#import "KeysManager.h"
#warning create Keychan.plist file and rename "Keychan-Sample" to "Keychan"
#define FileName @"Keychan-Sample"

@implementation KeysManager

+(NSDictionary *) getKeychan
{
    static NSDictionary *keysDict;
    
    if (keysDict==nil)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:FileName ofType:@"plist"];
        
        if (filePath)
        {
            keysDict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        }
    }
    
    return [keysDict copy];
}

+(NSDictionary *) getKeysFamily:(NSString *)keysFamily
{
    NSDictionary *keychanDict = [KeysManager getKeychan];
    
    return [keychanDict objectForKeyOrNil:keysFamily];
}

@end
