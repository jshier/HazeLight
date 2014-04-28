//
//  HLTCommunicatorTests.m
//  HazeLight
//
//  Created by Jon Shier on 2/14/14.
//  Copyright (c) 2014 Jon Shier. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHHTTPStubsResponse+JSON.h>
#import "HLTCommunicator.h"
#import "HLTDomain.h"
#import "HLTUser.h"

SPEC_BEGIN(HLTCommunicatorTests)

describe(@"HLTCommunicator", ^{
    __block HLTCommunicator *communicator;
    beforeEach(^{
        communicator = [[HLTCommunicator alloc] init];
    });
    
    afterAll(^{
        [OHHTTPStubs removeAllStubs];
    });
    
    context(@"init", ^{
        it(@"should intialize properly", ^{
            [[communicator should] beNonNil];
        });
    });
    
    context(@"fetchStatsWithDomain:withInterval:sucess:failure:", ^{
        
    });
    
    context(@"fetchDomainsForUser:success:failure:", ^{
        context(@"on success", ^{
            __block NSURLSessionDataTask *testTask;
            __block NSArray *testDomains;
            
            beforeAll(^{
                [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                    return YES;
                } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                    return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"dummy-domain-response.json", nil) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
                }];
                [communicator fetchDomainsForUser:[[HLTUser alloc] initWithEmail:@"test" apiKey:@"test"] success:^(NSURLSessionDataTask *task, NSArray *domains) {
                    testTask = task;
                    NSLog(@"Domains: %@", domains);
                    testDomains = domains;
                } failure:nil];
            });
            
            it(@"returns a stats object with the correct data", ^{
                [[expectFutureValue(testDomains) shouldEventually] beNonNil];
            });
            
            it(@"returns an NSURLSessionDataTask object", ^{
                [[expectFutureValue(testTask) shouldEventually] beNonNil];
            });
        });
        
        context(@"on CloudFlare auth failure", ^{
            __block NSURLSessionDataTask *testTask;
            __block NSError *testError;
            
            beforeAll(^{
                [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                    return YES;
                } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                    return [OHHTTPStubsResponse responseWithJSONObject:@{@"result":@"error",@"msg":@"Invalid token or email",@"err_code":@"E_UNAUTH"} statusCode:200 headers:@{@"Content-Type":@"application/json"}];
                }];
                [communicator fetchDomainsForUser:[[HLTUser alloc] initWithEmail:@"test" apiKey:@"test"] success:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
                    testTask = task;
                    testError = error;
                }];
            });
            
            it(@"returns an NSError object", ^{
                [[expectFutureValue(testError) shouldEventually] beNonNil];
                [[expectFutureValue(testError.domain) shouldEventually] equal:@"HLTCommunicatorErrorDomain"];
                [[expectFutureValue(@(testError.code)) shouldEventually] equal:@2];
            });
            
            it(@"returns an NSURLSessionDataTask object", ^{
                [[expectFutureValue(testTask) shouldEventually] beNonNil];
            });
        });
        
        context(@"on JSON parse failure", ^{
            __block NSURLSessionDataTask *testTask;
            __block NSError *testError;
            
            beforeAll(^{
                [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                    return YES;
                } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                    return [OHHTTPStubsResponse responseWithData:[@"invalid" dataUsingEncoding:NSUTF8StringEncoding] statusCode:200 headers:@{@"Content-Type":@"application/json"}];
                }];
                [communicator fetchDomainsForUser:[[HLTUser alloc] initWithEmail:@"test" apiKey:@"test"] success:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
                    testTask = task;
                    testError = error;
                }];
            });
            
            it(@"returns an NSError object indicating JSON parsing failure", ^{
                [[expectFutureValue(testError) shouldEventually] beNonNil];
                [[expectFutureValue(testError.domain) shouldEventually] equal:@"NSCocoaErrorDomain"];
                [[expectFutureValue(@(testError.code)) shouldEventually] equal:@3840];
            });
            
            it(@"returns an NSURLSessionDataTask object", ^{
                [[expectFutureValue(testTask) shouldEventually] beNonNil];
            });
        });
        
        context(@"on failure code returned", ^{
            __block NSURLSessionDataTask *testTask;
            __block NSError *testError;
            
            beforeAll(^{
                [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                    return YES;
                } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                    return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"dummy-domain-response.json", nil) statusCode:400 headers:@{@"Content-Type":@"application/json"}];
                }];
                [communicator fetchDomainsForUser:[[HLTUser alloc] initWithEmail:@"test" apiKey:@"test"] success:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
                    testTask = task;
                    testError = error;
                }];
            });
            
            it(@"returns an error object indicating bad code", ^{
                [[expectFutureValue(testError) shouldEventually] beNonNil];
                [[expectFutureValue(testError.domain) shouldEventually] equal:@"HLTCommunicatorErrorDomain"];
                [[expectFutureValue(@(testError.code)) shouldEventually] equal:@1];
            });
            
            it(@"returns an NSURLSessionDataTask object", ^{
                [[expectFutureValue(testTask) shouldEventually] beNonNil];
            });
        });
    });
});

SPEC_END