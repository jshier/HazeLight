//
//  ConvenienceFunctions.swift
//  HazeLight
//
//  Created by Jon Shier on 9/20/15.
//  Copyright © 2015 Jon Shier. All rights reserved.
//

import Foundation

func dispatchMain(block: dispatch_block_t) {
    dispatch_async(dispatch_get_main_queue(), block)
}
