//
//  ICFUser.m
//  iCloudFlare
//
//  Created by Jon Shier on 3/1/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import "ICFUser.h"

@implementation ICFUser

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
