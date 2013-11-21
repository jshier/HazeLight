//
//  HLUser.m
//  HazeLight
//
//  Created by Jon Shier on 3/1/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import "HLUser.h"

@implementation HLUser

- (id)initWithEmail:(NSString *)email apiKey:(NSString *)apiKey
{
    if ((self = [super init]))
    {
        _email = email;
        _apiKey = apiKey;
    }

    return self;
}

@end
