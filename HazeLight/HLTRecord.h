//
//  HLTRecord.h
//  HazeLight
//
//  Created by Jon Shier on 12/3/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//
//  Defined from the rec_load_all response attributes defined in section 3.3 of the CloudFlare API documentation (http://www.cloudflare.com/docs/client-api.html)

@import Foundation;

@interface HLTRecord : NSObject

@property (nonatomic, copy) NSString *recordID;
@property (nonatomic, copy) NSString *recordTag;
@property (nonatomic, copy) NSString *zoneName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *prio; //What is this?
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *displayContent;
@property (nonatomic, copy) NSString *ttl;
@property (nonatomic) NSNumber *ttlCeiling;
@property (nonatomic, copy) NSString *sslID;
@property (nonatomic, copy) NSString *sslStatus;
@property (nonatomic, copy) NSString *sslExpiresOn;
@property (nonatomic) NSNumber *autoTTL;
@property (nonatomic, copy) NSString *serviceMode;
@property (nonatomic, copy) NSDictionary *props;

@end
