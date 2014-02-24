//
//  HLTDomain.m
//  HazeLight
//
//  Created by Jon Shier on 5/5/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import "HLTDomain.h"
#import "HLTUtilityFunctions.h"

@implementation HLTDomain

- (instancetype)initWithUser:(HLTUser *)user andResponseDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _user = user;
        
        _allows = replaceWithNilIfNSNull(dictionary[@"allow"]);
        _confirmationCodes = replaceWithNilIfNSNull(dictionary[@"confirm_code"]);
        _displayName = replaceWithNilIfNSNull(dictionary[@"display_name"]);
        _fullQualifiedDNSNames = replaceWithNilIfNSNull(dictionary[@"fqdns"]);
        _hostID = replaceWithNilIfNSNull(dictionary[@"host_id"]);
        _hostPubname = replaceWithNilIfNSNull(dictionary[@"host_pubname"]);
        _hostWebsite = replaceWithNilIfNSNull(dictionary[@"host_website"]);
        _nameserverVanityMap = replaceWithNilIfNSNull(dictionary[@"ns_vanity_map"]);
        _originalDNSHost = replaceWithNilIfNSNull(dictionary[@"orig_dnshost"]);
        _originalNameserverNames = replaceWithNilIfNSNull(dictionary[@"orig_ns_names"]);
        _originalRegistrar = replaceWithNilIfNSNull(dictionary[@"orig_registrar"]);
        _properties = replaceWithNilIfNSNull(dictionary[@"props"]);
        _step = replaceWithNilIfNSNull(dictionary[@"step"]);
        _userID = replaceWithNilIfNSNull(dictionary[@"user_id"]);
        _vtxt = replaceWithNilIfNSNull(dictionary[@"vtxt"]);
        _zoneID = replaceWithNilIfNSNull(dictionary[@"zone_id"]);
        _zoneMode = replaceWithNilIfNSNull(dictionary[@"zone_mode"]);
        _zoneName = replaceWithNilIfNSNull(dictionary[@"zone_name"]);
        _zoneStatus = replaceWithNilIfNSNull(dictionary[@"zone_status"]);
        _zoneStatusClass = replaceWithNilIfNSNull(dictionary[@"zone_status_class"]);
        _zoneStatusDescription = replaceWithNilIfNSNull(dictionary[@"zone_status_desc"]);
        _zoneType = replaceWithNilIfNSNull(dictionary[@"zone_type"]);
    }
    
    return self;
}

@end
