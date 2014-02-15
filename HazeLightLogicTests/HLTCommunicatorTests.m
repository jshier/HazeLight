//
//  HLTCommunicatorTests.m
//  HazeLight
//
//  Created by Jon Shier on 2/14/14.
//  Copyright (c) 2014 Jon Shier. All rights reserved.
//

#import <Kiwi.h>
#import "HLTCommunicator.h"

SPEC_BEGIN(HLTCommunicatorTests)
describe(@"HLTCommunicator", ^{
    context(@"passes a Kiwi test", ^{
        __block HLTCommunicator *communicator;
        beforeEach(^{
            communicator = [[HLTCommunicator alloc] init];
        });
        it(@"should pass", ^{
            [[communicator should] beNonNil];
        });
    });
});


SPEC_END
