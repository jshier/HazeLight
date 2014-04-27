//
//  HLTUtilityFunctions.m
//  HazeLight
//
//  Created by Jon Shier on 4/27/14.
//  Copyright (c) 2014 Jon Shier. All rights reserved.
//

#import "HLTUtilityFunctions.h"

inline id replaceNullWithNil(id object)
{
    return ((object == [NSNull null]) ? nil : object);
}

inline id replaceNilWithNull(id object)
{
    return (object) ? object : [NSNull null];
}

inline id removeKeysWithNullValuesFromObject(id object)
{
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:object];
        for (id key in (NSDictionary *)object) {
            id value = object[key];
            if ([value isEqual:[NSNull null]]) {
                [mutableDictionary removeObjectForKey:key];
            }
            else if ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]]) {
                mutableDictionary[key] = removeKeysWithNullValuesFromObject(value);
            }
        }
        
        return [NSDictionary dictionaryWithDictionary:mutableDictionary];
    }
    else if ([object isKindOfClass:[NSArray class]]) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[(NSArray *)object count]];
        for (id value in (NSArray *)object) {
            [mutableArray addObject:removeKeysWithNullValuesFromObject(value)];
        }
        
        return [NSArray arrayWithArray:mutableArray];
    }
    
    return object;
}