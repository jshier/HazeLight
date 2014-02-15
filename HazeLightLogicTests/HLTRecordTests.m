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
    //FIXME: Should test custom initializer.
    _record = [[HLTRecord alloc] init];
    _record.recordID = @"recordID";
    _record.recordTag = @"recordTag";
    _record.zoneName = @"zoneName";
    _record.name = @"name";
    _record.displayName = @"displayName";
    _record.type = @"type";
    _record.prio = @"prio";
    _record.content = @"content";
    _record.displayContent = @"displayContent";
    _record.ttl = @"ttl";
    _record.ttlCeiling = @100;
    _record.sslID = @"sslID";
    _record.sslStatus = @"sslStatus";
    _record.sslExpiresOn = @"sslExpiresOn";
    _record.autoTTL = @100;
    _record.serviceMode = @"serviceMode";
    _record.props = @{@"key1": @"object1", @"key2": @"object2"};
}

- (void)tearDown
{
    _record = nil;
    [super tearDown];
}

- (void)testRecordHasRecordID
{
    XCTAssertEqualObjects(self.record.recordID, @"recordID", @"Record should have a recordID.");
}

- (void)testRecordHasRecordTag
{
    XCTAssertEqualObjects(self.record.recordTag, @"recordTag", @"Record should have recordTag.");
}

- (void)testRecordHasZoneName
{
    XCTAssertEqualObjects(self.record.zoneName, @"zoneName", @"Record should have zone name.");
}

- (void)testRecordHasName
{
    XCTAssertEqualObjects(self.record.name, @"name", @"Record should have name.");
}

- (void)testRecordHasDisplayName
{
    XCTAssertEqualObjects(self.record.displayName, @"displayName", @"Record should have displayName.");
}

- (void)testRecordHasType
{
    XCTAssertEqualObjects(self.record.type, @"type", @"Record should have type.");
}

- (void)testRecordHasPrio
{
    XCTAssertEqualObjects(self.record.prio, @"prio", @"Record should have prio.");
}

- (void)testRecordHasContent
{
    XCTAssertEqualObjects(self.record.content, @"content", @"Record should have content.");
}

- (void)testRecordHasDisplayContent
{
    XCTAssertEqualObjects(self.record.displayContent, @"displayContent", @"Record should have displayContent.");
}

- (void)testRecordHasTTL
{
    XCTAssertEqualObjects(self.record.ttl, @"ttl", @"Record should have ttl.");
}

- (void)testRecordHasTTLCeiling
{
    XCTAssertEqualObjects(self.record.ttlCeiling, @(100), @"Record should have ttlCeiling.");
}

- (void)testRecordHasSSLID
{
    XCTAssertEqualObjects(self.record.sslID, @"sslID", @"Record should have sslID.");
}

- (void)testRecordHasSSLStatus
{
    XCTAssertEqualObjects(self.record.sslStatus, @"sslStatus", @"Record should have sslStatus.");
}

- (void)testRecordHasSSLExpiresOn
{
    XCTAssertEqualObjects(self.record.sslExpiresOn, @"sslExpiresOn", @"Record should have sslExpiresOn.");
}

- (void)testHasAutoTTL
{
    XCTAssertEqualObjects(self.record.autoTTL, @(100), @"Record should have autoTTL.");
}

- (void)testRecordHasServiceMode
{
    XCTAssertEqualObjects(self.record.serviceMode, @"serviceMode", @"Record should have service mode.");
}

- (void)testRecordHasProps
{
    XCTAssertEqualObjects(self.record.props, (@{@"key1": @"object1", @"key2": @"object2"}), @"Record should have props.");
}

@end
