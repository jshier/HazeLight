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
        
        _allows = dictionary[@"allow"];
        _confirmationCodes = dictionary[@"confirm_code"];
        _displayName = dictionary[@"display_name"];
        _fullQualifiedDNSNames = dictionary[@"fqdns"];
        _hostID = dictionary[@"host_id"];
        _hostPubname = dictionary[@"host_pubname"];
        _hostWebsite = dictionary[@"host_website"];
        _nameserverVanityMap = dictionary[@"ns_vanity_map"];
        _originalDNSHost = dictionary[@"orig_dnshost"];
        _originalNameserverNames = dictionary[@"orig_ns_names"];
        _originalRegistrar = dictionary[@"orig_registrar"];
        _properties = dictionary[@"props"];
        _step = dictionary[@"step"];
        _userID = dictionary[@"user_id"];
        _vtxt = dictionary[@"vtxt"];
        _zoneID = dictionary[@"zone_id"];
        _zoneMode = dictionary[@"zone_mode"];
        _zoneName = dictionary[@"zone_name"];
        _zoneStatus = dictionary[@"zone_status"];
        _zoneStatusClass = dictionary[@"zone_status_class"];
        _zoneStatusDescription = dictionary[@"zone_status_desc"];
        _zoneType = dictionary[@"zone_type"];
    }
    
    return self;
}

@end
