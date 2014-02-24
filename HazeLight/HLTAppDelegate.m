//
//  HLTAppDelegate.m
//  HazeLight
//
//  Created by Jon Shier on 2/27/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import "HLTAppDelegate.h"
#import "HLTCommunicator.h"
#import "HLTUser.h"
#import "HLTStatsResponse.h"
#import "HLTDomain.h"

@implementation HLTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSBundle *classBundle = [NSBundle bundleForClass:[self class]];
    NSURL *apiKeyURL = [classBundle URLForResource:@"apiKey" withExtension:@"txt"];
    NSString *apiKey = [NSString stringWithContentsOfURL:apiKeyURL encoding:NSUTF8StringEncoding error:NULL];
    [[HLTCommunicator sharedCommunicator] fetchDomainsForUser:[[HLTUser alloc] initWithEmail:@"jon@jonshier.com" apiKey:apiKey]
                                                      success:^(NSURLSessionDataTask *task, NSArray *domains) {
                                                          NSLog(@"Domains: %@", domains);
                                                          for (HLTDomain *domain in domains) {
                                                              NSLog(@"Fetching stats for domain: %@", domain.zoneName);
                                                              [[HLTCommunicator sharedCommunicator] fetchStatsForDomain:domain withInterval:HLTStatRefreshInterval30Days
                                                                                                                success:^(NSURLSessionDataTask *task, HLTStatsResponse *stats) {
                                                                                                                    NSLog(@"Stats object: %@", stats);
                                                                                                                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                                                                    NSLog(@"Failed to fetch stats with error: %@", error);
                                                                                                                }];
                                                          }
                                                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                          NSLog(@"Failed to fetch domains with error: %@", error);
                                                      }];
    
    
    return YES;
}

@end
