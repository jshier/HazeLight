//
//  HLTRecordTests.m
//  HazeLight
//
//  Created by Jon Shier on 12/3/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HLTRecord.h"

@interface HLTRecordTests : XCTestCase

@property (nonatomic) HLTRecord *record;

@end

@implementation HLTRecordTests

- (void)setUp
{
    [super setUp];

    NSDictionary *sampleDictionary = @{@"rec_id": @"16606009",
                                       @"rec_tag": @"7f8e77bac02ba65d34e20c4b994a202c",
                                       @"zone_name": @"example.com",
                                       @"name": @"direct.example.com",
                                       @"display_name": @"direct",
                                       @"type": @"A",
                                       @"prio": @"priority",
                                       @"content": @"[server IP]",
                                       @"display_content": @"[server IP]",
                                       @"ttl": @"1",
                                       @"ttl_ceil": @86400,
                                       @"ssl_id": @"SSLID",
                                       @"ssl_status": @"SSLStatus",
                                       @"ssl_expires_on": @"SSLExpiresOn",
                                       @"auto_ttl": @1,
                                       @"service_mode": @"0",
                                       @"props": @{@"proxiable": @1,
                                                   @"cloud_on": @0,
                                                   @"cf_open": @1,
                                                   @"ssl": @0,
                                                   @"expired_ssl": @0,
                                                   @"expiring_ssl": @0,
                                                   @"pending_ssl": @0}};
    _record = [[HLTRecord alloc] initWithResponseDictionary:sampleDictionary];
}

- (void)tearDown
{
    _record = nil;
    [super tearDown];
}

- (void)testRecordHasRecordID
{
    XCTAssertEqualObjects(self.record.recordID, @"16606009", @"Record should have a recordID.");
}

- (void)testRecordHasRecordTag
{
    XCTAssertEqualObjects(self.record.recordTag, @"7f8e77bac02ba65d34e20c4b994a202c", @"Record should have recordTag.");
}

- (void)testRecordHasZoneName
{
    XCTAssertEqualObjects(self.record.zoneName, @"example.com", @"Record should have zone name.");
}

- (void)testRecordHasName
{
    XCTAssertEqualObjects(self.record.name, @"direct.example.com", @"Record should have name.");
}

- (void)testRecordHasDisplayName
{
    XCTAssertEqualObjects(self.record.displayName, @"direct", @"Record should have displayName.");
}

- (void)testRecordHasType
{
    XCTAssertEqualObjects(self.record.type, @"A", @"Record should have type.");
}

- (void)testRecordHasPrio
{
    XCTAssertEqualObjects(self.record.priority, @"priority", @"Record should have prio.");
}

- (void)testRecordHasContent
{
    XCTAssertEqualObjects(self.record.content, @"[server IP]", @"Record should have content.");
}

- (void)testRecordHasDisplayContent
{
    XCTAssertEqualObjects(self.record.displayContent, @"[server IP]", @"Record should have displayContent.");
}

- (void)testRecordHasTTL
{
    XCTAssertEqualObjects(self.record.TTL, @"1", @"Record should have ttl.");
}

- (void)testRecordHasTTLCeiling
{
    XCTAssertEqualObjects(self.record.TTLCeiling, @86400, @"Record should have ttlCeiling.");
}

- (void)testRecordHasSSLID
{
    XCTAssertEqualObjects(self.record.SSLID, @"SSLID", @"Record should have sslID.");
}

- (void)testRecordHasSSLStatus
{
    XCTAssertEqualObjects(self.record.SSLStatus, @"SSLStatus", @"Record should have sslStatus.");
}

- (void)testRecordHasSSLExpiresOn
{
    XCTAssertEqualObjects(self.record.SSLExpiresOn, @"SSLExpiresOn", @"Record should have sslExpiresOn.");
}

- (void)testHasAutoTTL
{
    XCTAssertEqualObjects(self.record.autoTTL, @1, @"Record should have autoTTL.");
}

- (void)testRecordHasServiceMode
{
    XCTAssertEqualObjects(self.record.serviceMode, @"0", @"Record should have service mode.");
}

- (void)testRecordHasProps
{
    XCTAssertEqualObjects(self.record.properties, (@{@"proxiable": @1,
                                                     @"cloud_on": @0,
                                                     @"cf_open": @1,
                                                     @"ssl": @0,
                                                     @"expired_ssl": @0,
                                                     @"expiring_ssl": @0,
                                                     @"pending_ssl": @0}), @"Record should have props.");
}

@end
