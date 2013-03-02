//
//  ICFUserTests.m
//  iCloudFlare
//
//  Created by Jon Shier on 3/1/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import "ICFUserTests.h"
#import "ICFUser.h"

@implementation ICFUserTests

- (void)testThatUserExists
{
    ICFUser *user = [[ICFUser alloc] init];
    STAssertNotNil(user, @"Should be able to create ICFUser instance.");
}

- (void)testThatUserCanBeCreatedWithEmail
{
    ICFUser *user = [[ICFUser alloc] initWithEmail:@"email" apiKey:nil];
    STAssertEqualObjects(user.email, @"email", @"ICFUser should be initialized with email specified.");
}

- (void)testThatUserCanBeCreatedWithAPIKey
{
    ICFUser *user = [[ICFUser alloc] initWithEmail:nil apiKey:@"key"];
    STAssertEqualObjects(user.apiKey, @"key", @"ICFUser should be initialized with API key specified.");
}

@end
