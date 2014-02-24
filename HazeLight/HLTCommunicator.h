//
//  HLTCommunicator.h
//  HazeLight
//
//  Created by Jon Shier on 5/5/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

@import Foundation;
#import "HLTStatRefreshInterval.h"

@class HLTDomain, HLTUser, HLTStatsResponse;

@interface HLTCommunicator : NSObject

+ (instancetype)sharedCommunicator;

- (NSURLSessionDataTask *)fetchStatsForDomain:(HLTDomain *)domain withInterval:(HLTStatRefreshInterval)interval
                    success:(void (^)(NSURLSessionDataTask *task, HLTStatsResponse *stats))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)fetchDomainsForUser:(HLTUser *)user
                    success:(void (^)(NSURLSessionDataTask *task, NSArray *domains))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
