//
//  SymbolDecoder.swift
//  SendMorseCode
//
//  Created by John James on 4/13/19.
//  Copyright © 2019 John James. All rights reserved.
//

import Foundation
import SwiftyJSON


class SymbolDecoder {
    //private var word: Word = SymbolDataDecoder.loadData(forFileName: "symbols", fileExtension: "json")!
    var tempword: [String] = [""]
    
// decode word of symbols from JSON string
    func loadJson(filename fileName: String) -> Word? {
        let se = SymbolEncoder()
        let jsonFilePath:String = Bundle.main.path(forResource: fileName, ofType: "json")! as String
        let jsonData = NSData(contentsOfFile: jsonFilePath as String)
//        else {
//                print("Couldn't find the file on disk or failed to read it")
//                return nil
//        }
        
        if let json = try? JSON(data: jsonData! as Data) {
            var symbols = [Symbol]()
            for sym in json.arrayValue {
                var marks = [Mark]()
                for mk in sym.arrayValue {
                    //print(mk)
                    let mark = se.createMarkFromString(str: mk)
                    marks.append(mark!)
                }
                let symbol = Symbol(marks: marks)
                //print(sym)
                symbols.append(symbol)
            }
            return Word(symbols: symbols)
        }
        return nil
    }
//    static public func decode(word : Word) -> String? {
//        //for symbol in word.symbols {
//
//        var dotDashes : String = ""
//        let symbols : [Symbol] = word.symbols
//        for sym in symbols {
//            let marks : [Mark] = sym.marks
//            for mark in marks {
//                guard let char : String = createDotDashFrom(mark: mark) else { return nil }
//                dotDashes.append(char)
//            }
//            //let returnDotDashes : String = reverseSymbolMap[dotDashes]
//        }
//        return dotDashes
    }
    
//    static private func createDotsAndDashes(dotDashes : String) -> String? {
//        return
//    }
    
//    private func createDotDashFrom(mark: Mark) -> String? {
//        switch mark {
//            case .Dit:
//                return "."
//            case .Dah:
//                return "-"
//        }
//        
//    }

