//
//  Helper.swift
//  Staqo
//
//  Created by SHAILY on 16/03/21.
//

import Foundation

class Helper {
    
    static func createTextReader(scannedText:String?) -> TextReader? {
        var textReader = TextReader()
        var document = Documents()
        document.id = "5"
        document.language = ""
        document.text = scannedText ?? ""
        textReader.documents?.append(document)
        return textReader
    }
    
    
    
}
