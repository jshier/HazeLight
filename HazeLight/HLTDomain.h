//
//  HLTDomain.h
//  HazeLight
//
//  Created by Jon Shier on 5/5/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//
//  Defined from the zone_load_multi response attributes defined in section 3.2 of the CloudFlare API doc. (https://www.cloudflare.com/docs/client-api.html)
#import <Foundation/Foundation.h>

@class HLTUser;

@interface HLTDomain : NSObject

@property (nonatomic) HLTUser *user;
@property (nonatomic, copy) NSDictionary *records;
@property (nonatomic, copy) NSString *zoneID;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *zoneName;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *zoneStatus;
@property (nonatomic, copy) NSString *zoneMode;
@property (nonatomic, copy) NSString *hostID;
@property (nonatomic, copy) NSString *zoneType;
@property (nonatomic, copy) NSString *hostPubname;
@property (nonatomic, copy) NSString *hostWebsite;
@property (nonatomic, copy) NSString *vtxt;
@property (nonatomic, copy) NSArray *fullQualifiedDNSNames;
@property (nonatomic, copy) NSString *step;
@property (nonatomic, copy) NSString *zoneStatusClass;
@property (nonatomic, copy) NSString *zoneStatusDescription;
@property (nonatomic, copy) NSArray *nameserverVanityMap;
@property (nonatomic, copy) NSString *originalRegistrar;
@property (nonatomic, copy) NSString *originalDNSHost;
@property (nonatomic, copy) NSArray *originalNameserverNames;
@property (nonatomic, copy) NSDictionary *properties;
@property (nonatomic, copy) NSDictionary *confirmationCodes;
@property (nonatomic, copy) NSArray *allows;

@end
