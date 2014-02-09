//
//  HLDomainTests.m
//  HazeLight
//
//  Created by Jon Shier on 11/20/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HLDomain.h"

@interface HLDomainTests : XCTestCase

@property (nonatomic) HLDomain *domain;

@end

@implementation HLDomainTests

- (void)setUp
{
    [super setUp];
    //FIXME: Need custom intializer for receieved dictionary. Test attributes for now.
    _domain = [[HLDomain alloc] init];
    self.domain.zoneID = @"zoneID";
    self.domain.userID = @"userID";
    self.domain.zoneName = @"zoneName";
    self.domain.displayName = @"displayName";
    self.domain.zoneStatus = @"zoneStatus";
    self.domain.zoneMode = @"zoneMode";
    self.domain.hostID = @"hostID";
    self.domain.zoneType = @"zoneType";
    self.domain.hostPubname = @"hostPubname";
    self.domain.hostWebsite = @"hostWebsite";
    self.domain.vtxt = @"vtxt";
    self.domain.fullQualifiedDNSNames = @[@"DNSName1", @"DNSName2"];
    self.domain.step = @"step";
    self.domain.zoneStatusClass = @"zoneStatusClass";
    self.domain.zoneStatusDescription = @"zoneStatusDescription";
    self.domain.nameserverVanityMap = @[@"Vanity1", @"Vanity2"];
    self.domain.originalRegistrar = @"originalRegistrar";
    self.domain.originalDNSHost = @"originalDNSHost";
    self.domain.originalNameserverNames = @[@"Nameserver1", @"Nameserver2", @"Nameserver3"];
    self.domain.properties = @{@"property1": @"value1", @"property2": @"value2"};
    self.domain.confirmationCodes = @{@"code1": @"code1", @"code2": @"code2"};
    self.domain.allows = @[@"allow1", @"allow2"];
    
}

- (void)tearDown
{
    _domain = nil;
    [super tearDown];
}

- (void)testDomainHasZoneID
{
    XCTAssertEqualObjects(self.domain.zoneID, @"zoneID", @"Domain should have a zoneID.");
}

- (void)testDomainHasUserID
{
    XCTAssertEqualObjects(self.domain.userID, @"userID", @"Domain should have a userID.");
}

- (void)testDomainHasZoneName
{
    XCTAssertEqualObjects(self.domain.zoneName, @"zoneName", @"Domain should have a zoneName.");
}

- (void)testDomainHasDisplayName
{
    XCTAssertEqualObjects(self.domain.displayName, @"displayName", @"Domain should have a displayName.");
}

- (void)testDomainHasZoneStatus
{
    XCTAssertEqualObjects(self.domain.zoneStatus, @"zoneStatus", @"Domain should have a zoneStatus.");
}

- (void)testDomainHasZoneMode
{
    XCTAssertEqualObjects(self.domain.zoneMode, @"zoneMode", @"Domain should have a zoneMode.");
}

- (void)testDomainHasHostID
{
    XCTAssertEqualObjects(self.domain.hostID, @"hostID", @"Domain should have a hostID.");
}

- (void)testDomainHasZoneType
{
    XCTAssertEqualObjects(self.domain.zoneType, @"zoneType", @"Domain should have a zoneType.");
}

- (void)testDomainHasHostPubname
{
    XCTAssertEqualObjects(self.domain.hostPubname, @"hostPubname", @"Domain should have a hostPubname.");
}

- (void)testDomainHasHostWebsite
{
    XCTAssertEqualObjects(self.domain.hostWebsite, @"hostWebsite", @"Domain should have a hostWebsite.");
}

- (void)testDomainHasVtxt
{
    XCTAssertEqualObjects(self.domain.vtxt, @"vtxt", @"Domain should have a vtxt.");
}

- (void)testDomainHasFullQualifiedDNSNames
{
    XCTAssertEqualObjects(self.domain.fullQualifiedDNSNames, (@[@"DNSName1", @"DNSName2"]), @"Domain should have fullQualifiedDNSNames.");
}

- (void)testDomainHasStep
{
    XCTAssertEqualObjects(self.domain.step, @"step", @"Domain should have a step.");
}

- (void)testDomainHasZoneStatusClass
{
    XCTAssertEqualObjects(self.domain.zoneStatusClass, @"zoneStatusClass", @"Domain should have a zoneStatusClass.");
}

- (void)testDomainHasZoneStatusDescription
{
    XCTAssertEqualObjects(self.domain.zoneStatusDescription, @"zoneStatusDescription", @"Domain should have a zoneStatusDescription.");
}

- (void)testDomainHasNameserverVanityMap
{
    XCTAssertEqualObjects(self.domain.nameserverVanityMap, (@[@"Vanity1", @"Vanity2"]), @"Domain should have a nameserverVanityMap.");
}

- (void)testDomainHasOriginalRegistrar
{
    XCTAssertEqualObjects(self.domain.originalRegistrar, @"originalRegistrar", @"Domain should have an originalRegistrar.");
}

- (void)testDomainHasOriginalDNSHost
{
    XCTAssertEqualObjects(self.domain.originalDNSHost, @"originalDNSHost", @"Domain should have an originalDNSHost.");
}

- (void)testDomainHasOriginalNameserverNames
{
    XCTAssertEqualObjects(self.domain.originalNameserverNames, (@[@"Nameserver1", @"Nameserver2", @"Nameserver3"]), @"Domain should have originalNameserverNames.");
}

- (void)testDomainHasProperties
{
    XCTAssertEqualObjects(self.domain.properties, (@{@"property1": @"value1", @"property2": @"value2"}), @"Domain should have properties.");
}

- (void)testDomainHasConfirmationCodes
{
    XCTAssertEqualObjects(self.domain.confirmationCodes, (@{@"code1": @"code1", @"code2": @"code2"}), @"Domain should have confirmationCodes.");
}

- (void)testDomainHasAllows
{
    XCTAssertEqualObjects(self.domain.allows, (@[@"allow1", @"allow2"]), @"Domain should have an allows.");
}
@end
