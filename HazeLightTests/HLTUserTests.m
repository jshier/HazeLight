//
//  HLTUserTests.m
//  HazeLight
//
//  Created by Jon Shier on 3/1/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HLTUser.h"

@interface HLTUserTests : XCTestCase

@property (nonatomic) HLTUser *user;

@end

@implementation HLTUserTests

- (void)setUp
{
    [super setUp];
    _user = [[HLTUser alloc] initWithEmail:@"email" apiKey:@"key"];
}

- (void)tearDown
{
    _user = nil;
    [super tearDown];
}

- (void)testThatUserExists
{
    XCTAssertNotNil(self.user, @"Should be able to create HLTUser instance.");
}

- (void)testThatUserCanBeCreatedWithEmail
{
    XCTAssertEqualObjects(self.user.email, @"email", @"HLTUser should be initialized with email specified.");
}

- (void)testThatUserCanBeCreatedWithAPIKey
{
    XCTAssertEqualObjects(self.user.apiKey, @"key", @"HLTUser should be initialized with API key specified.");
}

@end
