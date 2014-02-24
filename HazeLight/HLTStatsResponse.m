//
//  HLTStatsResponse.m
//  HazeLight
//
//  Created by Jon Shier on 2/23/14.
//  Copyright (c) 2014 Jon Shier. All rights reserved.
//

#import "HLTStatsResponse.h"

@implementation HLTStatsResponse

- (instancetype)initWithDomain:(HLTDomain *)domain andResponseDictionary:(NSDictionary *)responseDictionary
{
    self = [super init];
    if (self)
    {
        _domain = domain;
        _cloudFlareBandwidthServed = responseDictionary[@"bandwidthServed"][@"cloudflare"];
        _userBandwidthServed = responseDictionary[@"bandwidthServed"][@"user"];
        _cachedExpryTime = responseDictionary[@"cachedExpryTime"];
        _cachedServerTime = responseDictionary[@"cachedServerTime"];
        _currentServerTime = responseDictionary[@"currentServerTime"];
        _interval = [responseDictionary[@"interval"] unsignedIntegerValue];
        _cloudFlareRequestsServed = responseDictionary[@"requestsServed"][@"cloudflare"];
        _userRequestsServed = responseDictionary[@"requestsServed"][@"user"];
        _trafficBreakdownEstimated = [responseDictionary[@"trafficBreakdown"][@"estimated"] boolValue];
        _crawlerPageViews = responseDictionary[@"trafficBreakdown"][@"pageviews"][@"crawler"];
        _regularPageViews = responseDictionary[@"trafficBreakdown"][@"pageviews"][@"regular"];
        _threatPageViews = responseDictionary[@"trafficBreakdown"][@"pageviews"][@"threat"];
        _uniqueCrawlerPageViews = responseDictionary[@"trafficBreakdown"][@"uniques"][@"crawler"];
        _uniqueRegularPageViews = responseDictionary[@"trafficBreakdown"][@"uniques"][@"regular"];
        _uniqueThreatPageViews = responseDictionary[@"trafficBreakdown"][@"uniques"][@"threat"];
    }
    
    return self;
}

@end
