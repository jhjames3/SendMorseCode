//
//  WordDecoder.swift
//  SendMorseCode
//
//  Created by John James on 4/13/19.
//  Copyright © 2019 John James. All rights reserved.
//
// this goes from a word of symbols which are in the form of Marks to a letter in the form of a String

import Foundation

class WordDecoder {
    
    var characterMap: [String: String] = DataLoader.loadData(forFileName: "morse", fileExtension: "json")!
    
    var reverseSymbolMap = [String: String]()
    
    init() {
        let keys = Array(characterMap.keys)
        for key in keys {
            let char = characterMap[key]
            reverseSymbolMap[String(char!)] = key
        }
    }
    
    public func decodeWordOfSymbols(word: Word) -> String{
        var wordStr = ""
        let symbols = word.symbols
        for sym in symbols {
            var codedword = ""
            let marks = sym.marks
            for mark in marks {
                if mark == .Dah {
                    codedword.append("-")
                } else if mark == .Dit {
                    codedword.append(".")
                }
            }
            wordStr.append(self.decode(dotdashletter: codedword)!)
        }
        return wordStr
    }
    
    private func decode(dotdashletter : String ) -> String? {
        //return reverseSymbolMap[dotdashletter]
        guard let letter = reverseSymbolMap[dotdashletter] else {return "*"}
        return letter
    }
}
