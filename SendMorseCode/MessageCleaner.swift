//
//  MessageCleaner.swift
//  MorseNew
//
//  Created by adam smith on 7/15/16.
//  Copyright © 2016 adamontherun. All rights reserved.
//

import Foundation

struct MessageCleaner {
    
    static func clean(message: String) -> String {
        let trimmedString = //message.stringByTrimmingCharactersInSet( NSCharacterSet.whitespaceAndNewlineCharacterSet()
            message.trimmingCharacters(in: CharacterSet.whitespaces)

        return trimmedString
    }
}
