//
//  HLTCommunicatorTests.m
//  HazeLight
//
//  Created by Jon Shier on 2/14/14.
//  Copyright (c) 2014 Jon Shier. All rights reserved.
//

#import <Kiwi.h>
#import "HLTCommunicator.h"
#import "HLTDomain.h"

@interface HLTCommunicator ()

@property (nonatomic) NSURLSession *session;

@end

SPEC_BEGIN(HLTCommunicatorTests)

describe(@"HLTCommunicator", ^{
    __block HLTCommunicator *communicator;
    beforeEach(^{
        communicator = [[HLTCommunicator alloc] init];
    });
    context(@"init", ^{
        it(@"should intialize properly", ^{
            [[communicator should] beNonNil];
        });
        it(@"should initialize a session property", ^{
            [[communicator.session should] beNonNil];
        });
        
    });
    context(@"fetchStatsWithDomain:withInterval:sucess:failure:", ^{
        context(@"on success", ^{
            beforeEach(^{
                
            });
            it(@"returns a stats object with the correct data", ^{
                
            });
            it(@"returns an NSURLSessionDataTask object", ^{
                
            });

        });
        context(@"on failure", ^{
            beforeEach(^{
                
            });
            it(@"returns an NSError object", ^{
                
            });
            it(@"returns an NSURLSessionDataTask object", ^{
                
            });
        });
    });
    context(@"fetchDomainsForUser:success:failure:", ^{
        
    });
});

SPEC_END