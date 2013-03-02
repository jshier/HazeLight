//
//  ICFUser.h
//  iCloudFlare
//
//  Created by Jon Shier on 3/1/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICFUser : NSObject

@property (weak, nonatomic, readonly) NSString *email;
@property (weak, nonatomic, readonly) NSString *apiKey;

- (id)initWithEmail:(NSString *)email apiKey:(NSString *)apiKey;

@end
