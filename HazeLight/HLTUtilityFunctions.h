//
//  HLTUtilityFunctions.h
//  HazeLight
//
//  Created by Jon Shier on 2/23/14.
//  Copyright (c) 2014 Jon Shier. All rights reserved.
//

@import Foundation;

id replaceWithNilIfNSNull(id object)
{
    return ((object == [NSNull null]) ? nil : object);
}