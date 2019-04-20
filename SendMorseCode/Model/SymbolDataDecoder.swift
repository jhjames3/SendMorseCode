//
//  SymbolDataDecoder.swift
//  SendMorseCode
//
//  Created by John James on 4/19/19.
//  Copyright © 2019 John James. All rights reserved.
//

import Foundation

class SymbolDataDecoder {
    static func loadData(forFileName fileName: String, fileExtension: String) -> Word? {
        
        let path = Bundle.main.path(forResource: fileName, ofType: fileExtension)!
        let jsonData = NSData(contentsOfFile: path)!
        
        let json = try! JSONSerialization.jsonObject(with: jsonData as Data, options:JSONSerialization.ReadingOptions(rawValue: 0))
        //let word : Word = try! JSONDecoder().decode(Word.self, from: json as! Data)
        //guard let word: Word = decoder.decode([Word].self, from: json) else { return nil }

        //guard let jsonDictionary = json as? [String : String] else { return nil }
        return nil
    }
}
