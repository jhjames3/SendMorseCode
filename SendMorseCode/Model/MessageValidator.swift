//
//  MessageValidator.swift
//  MorseNew
//
//  Created by adam smith on 7/15/16.
//  Copyright © 2016 adamontherun. All rights reserved.
//

import Foundation

struct MessageValidator {
    
    static func validate(message: String) -> Bool
    {
        for letter in message {
            
            // Checks if all the characters entered are able to be converted to Morse code
            if SymbolEncoder.characterMap[String(letter)] == nil {
                
                // The only character allowed that's not in the characterMap is a blank space
                if letter == " " { continue }
                return false
            }
        }
        return message.count > 0
    }
}
