//
//  LIBModel.swift
//  The Liberator
//
//  Created by Allison Wei on 4/24/19.
//  Copyright © 2019 Chase Wooten. All rights reserved.
//

import Foundation

class madlib {
    
    var title : String
    var theWholeAssString : String
    var words : [String]
    
    //index -> (filled?, type, text)
    var blanks : [Int:(Bool,String,String)]
    var blankTypes : [String]
    var completed : Bool
    
    
    //init a blank madlib from file: first word is the title then hopefully does the rest right
    //haha, crying
    init(fileName : String){
        
        words = [String]()
        theWholeAssString = "that's it that the project"
        blanks = [Int:(Bool,String,String)]()
        blankTypes = [String]()
        
        do {
            if let path = Bundle.main.path(forResource: fileName, ofType: "txt"){
                theWholeAssString = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                words = theWholeAssString.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
//              print(words)
            }
        } catch _ as NSError {
            print("F")
        }
        
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z]+")
            let nsString = theWholeAssString as NSString
            let results = regex.matches(in: theWholeAssString, range: NSRange(location: 0, length: nsString.length))
            blankTypes = results.map { nsString.substring(with: $0.range)}
        } catch {
            print("F, part 2")
        }
        
        for i in 0...blankTypes.count {
            blanks[i] = (false, blankTypes[i],"")
        }
        
        title = words[0]
        completed = false 
        print(blanks)
        
    }
}

class LIBModel {
    let catagories = [String:[madlib]]()
}
