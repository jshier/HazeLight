//
//  ICFDomain.h
//  iCloudFlare
//
//  Created by Jon Shier on 5/5/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//
//  Defined from the zone_load_multi response attributes defined in section 3.2 of the CloudFlare API doc. (https://www.cloudflare.com/docs/client-api.html)
#import <Foundation/Foundation.h>

@class ICFUser;

@interface ICFDomain : NSObject
@property (nonatomic) ICFUser *user;
@property (nonatomic) NSString *zoneID;
@property (nonatomic) NSString *userID;
@property (nonatomic) NSString *zoneName;
@property (nonatomic) NSString *displayName;
@property (nonatomic) NSString *zoneStatus;
@property (nonatomic) NSString *zoneMode;
@property (nonatomic) NSString *hostID;
@property (nonatomic) NSString *zoneType;
@property (nonatomic) NSString *hostPubname;
@property (nonatomic) NSString *hostWebsite;
@property (nonatomic) NSString *vtxt;
@property (nonatomic) NSArray *fullQualifiedDNSNames;
@property (nonatomic) NSString *step;
@property (nonatomic) NSString *zoneStatusClass;
@property (nonatomic) NSString *zoneStatusDescription;
@property (nonatomic) NSArray *nameserverVanityMap;
@property (nonatomic) NSString *originalRegistrar;
@property (nonatomic) NSString *originalDNSHost;
@property (nonatomic) NSArray *originalNameserverNames;
@property (nonatomic) NSDictionary *properties;
@property (nonatomic) NSDictionary *confirmationCodes;
@property (nonatomic) NSArray *allows;


@end
