//
//  HLUser.h
//  HazeLight
//
//  Created by Jon Shier on 3/1/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLUser : NSObject

@property (nonatomic, readonly) NSString *email;
@property (nonatomic, readonly) NSString *apiKey;
@property (nonatomic, copy) NSArray *domains;

- (id)initWithEmail:(NSString *)email apiKey:(NSString *)apiKey;

@end
