//
//  HLUserTests.m
//  HazeLight
//
//  Created by Jon Shier on 3/1/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HLUser.h"

@interface HLUserTests : XCTestCase

@property (nonatomic) HLUser *user;

@end

@implementation HLUserTests

- (void)setUp
{
    [super setUp];
    _user = [[HLUser alloc] initWithEmail:@"email" apiKey:@"key"];
}

- (void)tearDown
{
    _user = nil;
    [super tearDown];
}

- (void)testThatUserExists
{
    XCTAssertNotNil(self.user, @"Should be able to create HLUser instance.");
}

- (void)testThatUserCanBeCreatedWithEmail
{
    XCTAssertEqualObjects(self.user.email, @"email", @"HLUser should be initialized with email specified.");
}

- (void)testThatUserCanBeCreatedWithAPIKey
{
    XCTAssertEqualObjects(self.user.apiKey, @"key", @"HLUser should be initialized with API key specified.");
}

@end
