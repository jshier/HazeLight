//
//  HLTRecord.m
//  HazeLight
//
//  Created by Jon Shier on 12/3/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import "HLTRecord.h"

static NSString * const kHLTRecordRecordID = @"rec_id";
static NSString * const kHLTRecordRecordTag = @"rec_tag";
static NSString * const kHLTRecordZoneName = @"zone_name";
static NSString * const kHLTRecordName = @"name";
static NSString * const kHLTRecordDisplayName = @"display_name";
static NSString * const kHLTRecordType = @"type";
static NSString * const kHLTRecordPriority = @"prio";
static NSString * const kHLTRecordContent = @"content";
static NSString * const kHLTRecordDisplayContent = @"display_content";
static NSString * const kHLTRecordTTL = @"ttl";
static NSString * const kHLTRecordTTLCeiling = @"ttl_ceil";
static NSString * const kHLTRecordSSLID = @"ssl_id";
static NSString * const kHLTRecordSSLStatus = @"ssl_status";
static NSString * const kHLTRecordSSLExpiresOn = @"ssl_expires_on";
static NSString * const kHLTRecordAutoTTL = @"auto_ttl";
static NSString * const kHLTRecordServiceMode = @"service_mode";
static NSString * const kHLTRecordProperties = @"props";

@implementation HLTRecord

- (instancetype)initWithResponseDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _recordID = dict[kHLTRecordRecordID];
        _recordTag = dict[kHLTRecordRecordTag];
        _zoneName = dict[kHLTRecordZoneName];
        _name = dict[kHLTRecordName];
        _displayName = dict[kHLTRecordDisplayName];
        _type = dict[kHLTRecordType];
        _priority = dict[kHLTRecordPriority];
        _content = dict[kHLTRecordContent];
        _displayContent = dict[kHLTRecordDisplayContent];
        _TTL = dict[kHLTRecordTTL];
        _TTLCeiling = dict[kHLTRecordTTLCeiling];
        _SSLID = dict[kHLTRecordSSLID];
        _SSLStatus = dict[kHLTRecordSSLStatus];
        _SSLExpiresOn = dict[kHLTRecordSSLExpiresOn];
        _autoTTL = dict[kHLTRecordAutoTTL];
        _serviceMode = dict[kHLTRecordServiceMode];
        _properties = dict[kHLTRecordProperties];
    }
    
    return self;
}

@end
