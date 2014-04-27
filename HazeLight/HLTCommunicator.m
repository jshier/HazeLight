//
//  HLTCommunicator.m
//  HazeLight
//
//  Created by Jon Shier on 5/5/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import "HLTCommunicator.h"
#import "HLTDomain.h"
#import "HLTUser.h"
#import "HLTStatsResponse.h"
#import "HLTUtilityFunctions.h"

static NSString * const baseURLString = @"https://www.cloudflare.com/api_json.html";

@interface HLTCommunicator ()

@property (nonatomic) NSURLSession *session;

@end

@implementation HLTCommunicator

+ (instancetype)sharedCommunicator
{
    static HLTCommunicator *sharedCommunicator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCommunicator = [[HLTCommunicator alloc] init];
    });
    
    return sharedCommunicator;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    
    return self;
}

- (NSURLSessionDataTask *)fetchStatsForDomain:(HLTDomain *)domain withInterval:(HLTStatRefreshInterval)interval
                    success:(void (^)(NSURLSessionDataTask *task, HLTStatsResponse *stats))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *type = @"stats";

    NSData *postData = [[NSString stringWithFormat:@"a=%@&tkn=%@&email=%@&z=%@&interval=%@", type, domain.user.apiKey, domain.user.email, domain.zoneName, @(interval)] dataUsingEncoding:NSUTF8StringEncoding];

    __block NSURLSessionDataTask *task = [self.session dataTaskWithRequest:[self requestWithBodyData:postData] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            NSError *decodeError;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&decodeError];
            if (decodeError) {
                if (failure) {
                    failure(task, decodeError);
                }
            }
            if (success) {
                success(task, [[HLTStatsResponse alloc] initWithDomain:domain andResponseDictionary:responseDictionary[@"response"][@"result"][@"objs"][0]]);
            }
        }
    }];
    
    [task resume];
    
    return task;
}

- (NSURLSessionDataTask *)fetchDomainsForUser:(HLTUser *)user
                    success:(void (^)(NSURLSessionDataTask *task, NSArray *domains))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *type = @"zone_load_multi";
    
    NSData *postData = [[NSString stringWithFormat:@"a=%@&tkn=%@&email=%@", type, user.apiKey, user.email] dataUsingEncoding:NSUTF8StringEncoding];
    
    __block NSURLSessionDataTask *task = [self.session dataTaskWithRequest:[self requestWithBodyData:postData] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            NSError *decodeError;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&decodeError];
            if (decodeError) {
                if (failure) {
                    failure(task, decodeError);
                }
            }
            responseDictionary = removeKeysWithNullValuesFromObject(responseDictionary);
            NSArray *rawDomains = responseDictionary[@"response"][@"zones"][@"objs"];
            NSMutableArray *domains = [[NSMutableArray alloc] init];
            for (NSDictionary *domainDict in rawDomains) {
                [domains addObject:[[HLTDomain alloc] initWithUser:user andResponseDictionary:domainDict]];
            }
            if (success) {
                success(task, [domains copy]);
            }
        }
    }];
    
    [task resume];
    
    return task;
}

- (NSURLRequest *)requestWithBodyData:(NSData *)data
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseURLString]];
    request.HTTPMethod = @"POST";
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    return request;
}

@end
