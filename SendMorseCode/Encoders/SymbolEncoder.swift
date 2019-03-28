//
//  SymbolEncoder.swift
//  MorseNew
//
//  Created by adam smith on 7/12/16.
//  Copyright © 2016 adamontherun. All rights reserved.
//

import Foundation

class SymbolEncoder {
    
    static var characterMap: [String: String] = DataLoader.loadData(forFileName: "morse", fileExtension: "json")!
    
    static func encode(character : Character) -> Symbol? {
        
        guard let dotsAndDashes = createDotsAndDashes(forCharacter: character) else { return nil }
        var marks = [Mark]()
        for dotOrDash in dotsAndDashes {
            guard let mark = createMarkFrom(dotOrDash: dotOrDash) else { return nil }
            marks.append(mark)
        }
        return Symbol(marks: marks)
    }
    
    static private func createDotsAndDashes(forCharacter character: Character) -> String? {
        let newString = String(character)//.trimmingCharacters(in: CharacterSet.lowercaseLetters)

        return characterMap[newString]
    
    }
    
    static private func createMarkFrom(dotOrDash: Character) -> Mark? {
        
        switch dotOrDash {
        case ".":
            return Mark.Dit
        case "-":
            return Mark.Dah
        default:
            return nil
        }
    }
}
