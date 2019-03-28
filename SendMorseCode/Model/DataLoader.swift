//
//  DataLoader.swift
//  morse
//
//  Created by adam smith on 7/3/16.
//  Copyright © 2016 adam smith. All rights reserved.
//

import Foundation


class DataLoader {
    static func loadData(forFileName fileName: String, fileExtension: String) -> [String:String]? {
        
        let path = Bundle.main.path(forResource: fileName, ofType: fileExtension)!
        let jsonData = NSData(contentsOfFile: path)!
        
        let json = try! JSONSerialization.jsonObject(with: jsonData as Data, options:JSONSerialization.ReadingOptions(rawValue: 0))
        
        guard let jsonDictionary = json as? [String : String] else { return nil }
        return jsonDictionary
    }
}
