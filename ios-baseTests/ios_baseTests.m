//
//  ios_baseTests.m
//  ios-baseTests
//
//  Created by Danis Ziganshin on 14.02.14.
//  Copyright (c) 2014 FlatStack. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ios_baseTests : XCTestCase

@end

@implementation ios_baseTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
#warning Don't you forget add some tests
    // for example:
    XCTAssertTrue(1==1, @"This is not true");
    XCTAssertNotNil([[NSObject alloc] init], @"Object is nil");
    XCTAssertEqual(@"string", @"string", @"Objects is not equal");
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
