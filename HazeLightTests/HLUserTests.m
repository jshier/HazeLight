//
//  ICFUserTests.m
//  iCloudFlare
//
//  Created by Jon Shier on 3/1/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import "HLUserTests.h"
#import "HLUser.h"

@implementation HLUserTests

- (void)testThatUserExists
{
    HLUser *user = [[HLUser alloc] init];
    XCTAssertNotNil(user, @"Should be able to create ICFUser instance.");
}

- (void)testThatUserCanBeCreatedWithEmail
{
    HLUser *user = [[HLUser alloc] initWithEmail:@"email" apiKey:nil];
    XCTAssertEqualObjects(user.email, @"email", @"ICFUser should be initialized with email specified.");
}

- (void)testThatUserCanBeCreatedWithAPIKey
{
    HLUser *user = [[HLUser alloc] initWithEmail:nil apiKey:@"key"];
    XCTAssertEqualObjects(user.apiKey, @"key", @"ICFUser should be initialized with API key specified.");
}

@end
