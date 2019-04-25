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
        
        var lines = [String]() //this is literally to extract the title
        words = [String]()
        theWholeAssString = "that's it that's the project"
        blanks = [Int:(Bool,String,String)]()
        blankTypes = [String]()
        
        do {
            if let path = Bundle.main.path(forResource: fileName, ofType: "txt"){
                theWholeAssString = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                words = theWholeAssString.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
                lines = theWholeAssString.components(separatedBy: NSCharacterSet.newlines)
            }
        } catch _ as NSError {
            print("F")
        }
        
        do {
            let regex = try NSRegularExpression(pattern: "<[A-Z ]+> ")
            let nsString = theWholeAssString as NSString
            let results = regex.matches(in: theWholeAssString, range: NSRange(location: 0, length: nsString.length))
            blankTypes = results.map { nsString.substring(with: $0.range)}
        } catch {
            print("F, part 2")
        }
        
        for i in 0..<blankTypes.count {
            let blankTypeDisplay = blankTypes[i].lowercased()
            var actualBlankDisplay = "something went wrong, lol"
            do {
                let regexBCTHERESNOSUBSTRING = try NSRegularExpression(pattern: "[a-z ]+")
                let nsString = blankTypeDisplay as NSString
                let mysteryObject = regexBCTHERESNOSUBSTRING.firstMatch(in: blankTypeDisplay, range: NSRange(location: 0, length: nsString.length))
                actualBlankDisplay = nsString.substring(with: mysteryObject!.range)
            } catch {
                print("F, part 3")
            }
            blanks[i] = (false, actualBlankDisplay,"")
        }
        
        title = lines[0]
        completed = false
        print(title)
        print(blanks)
    }
    
    func fillBlank(position : Int, text : String){
        blanks[position]?.0 = true
        blanks[position]?.2 = text
    }
    
    func deleteBlank(position : Int, text : String){
        blanks[position]?.0 = false
    }
    
    func getTypeOfPosition(pos : Int) -> String {
        return blanks[pos]?.1 ?? "something went wrong"
    }
    
    func isComplete() -> Bool {
        for i in 0..<blanks.count{
            if(blanks[i]!.0 == false){
                return false
            }
        }
        return true
    }
    
    func getFullText() -> String{
        return "lol, do it"
    }
}

class LIBModel {
    let catagories = [String:[madlib]]()
}

