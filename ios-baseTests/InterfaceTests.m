//
//  InterfaceTests.m
//  ios-base
//
//  Created by Никита Фомин on 10.03.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <KIF/KIF.h>

@interface InterfaceTests : KIFTestCase

@end

@implementation InterfaceTests

- (void)beforeAll {
    
}

- (void)afterAll {
    
}

- (void)beforeEach {
    
}

- (void)afterEach {
    
}

- (void)testButtonClick {
#warning Simple UI test
    [tester tapViewWithAccessibilityLabel:@"Check it!"];
}

@end
