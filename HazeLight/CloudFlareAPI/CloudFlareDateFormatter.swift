//
//  CloudFlareDateFormatter.swift
//  HazeLight
//
//  Created by Jon Shier on 8/30/15.
//  Copyright © 2015 Jon Shier. All rights reserved.
//

import Foundation
import Argo

let ISO8601DateFormatter: NSDateFormatter = {
    let dateFormatter = NSDateFormatter()
    let enUSPosixLocale = NSLocale(localeIdentifier: "en_US_POSIX")
    dateFormatter.locale = enUSPosixLocale
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
    
    return dateFormatter
}()

let toISO8601Date: String -> Decoded<NSDate> = {
    return .fromOptional(ISO8601DateFormatter.dateFromString($0))
}
