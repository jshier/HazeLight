//
//  HLTStatsResponse.h
//  HazeLight
//
//  Created by Jon Shier on 2/23/14.
//  Copyright (c) 2014 Jon Shier. All rights reserved.
//

@import Foundation;
#import "HLTStatRefreshInterval.h"

@class HLTDomain;

@interface HLTStatsResponse : NSObject

@property (nonatomic) HLTDomain *domain;

@property (nonatomic) NSNumber *cloudFlareBandwidthServed;
@property (nonatomic) NSNumber *userBandwidthServed;
@property (nonatomic) NSNumber *cachedExpryTime;
@property (nonatomic) NSNumber *cachedServerTime;
@property (nonatomic) NSNumber *currentServerTime;
@property (nonatomic) HLTStatRefreshInterval interval;
@property (nonatomic) NSNumber *cloudFlareRequestsServed;
@property (nonatomic) NSNumber *userRequestsServed;
@property (nonatomic) BOOL trafficBreakdownEstimated;
@property (nonatomic) NSNumber *crawlerPageViews;
@property (nonatomic) NSNumber *regularPageViews;
@property (nonatomic) NSNumber *threatPageViews;
@property (nonatomic) NSNumber *uniqueCrawlerPageViews;
@property (nonatomic) NSNumber *uniqueRegularPageViews;
@property (nonatomic) NSNumber *uniqueThreatPageViews;

- (instancetype)initWithDomain:(HLTDomain *)domain andResponseDictionary:(NSDictionary *)responseDictionary;

@end
