//
//  LIBModel.swift
//  The Liberator
//
//  Created by Allison Wei on 4/24/19.
//  Copyright © 2019 Chase Wooten. All rights reserved.
//

import Foundation

class madlib {
    
    var key : String
    var fileName : String
    var title : String
    var titleLength : Int
    var theWholeString : String
    var words : [String]
    
    //index -> (filled?, type, text)
    var blanks : [Int:(Bool,String,String)]
    var blankTypes : [String]
    var completed : Bool
    
    
    //init a blank madlib from file: first word is the title then hopefully does the rest right
    init(){
        //this does nothing :)
        self.fileName = "F"
        key = "lol, shit"
        title = "U"
        titleLength = 0
        theWholeString = "lol"
        words = ["yee"]
        blanks = [Int:(Bool,String,String)]()
        blankTypes = ["whysomany"]
        completed = false
    }
    
    init(fileName : String){
        self.fileName = fileName
        var lines = [String]() //this is literally to extract the title
        words = [String]()
        theWholeString = "that's it that's the project"
        blanks = [Int:(Bool,String,String)]()
        blankTypes = [String]()
        
        do {
            if let path = Bundle.main.path(forResource: fileName, ofType: "txt"){
                theWholeString = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                words = theWholeString.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
                lines = theWholeString.components(separatedBy: NSCharacterSet.newlines)
            }
        } catch _ as NSError {
            print("F")
        }
        
        do {
            let regex = try NSRegularExpression(pattern: "<[A-Z ()\\-]+>")
            let nsString = theWholeString as NSString
            let results = regex.matches(in: theWholeString, range: NSRange(location: 0, length: nsString.length))
            blankTypes = results.map {nsString.substring(with: $0.range)}
        } catch {
            print("F, part 2")
        }
        
        for i in 0..<blankTypes.count {
            let blankTypeDisplay = blankTypes[i].lowercased()
            var actualBlankDisplay = "something went wrong, lol"
            do {
                let regexBCTHERESNOSUBSTRING = try NSRegularExpression(pattern: "[a-z ()\\-]+")
                let nsString = blankTypeDisplay as NSString
                let mysteryObject = regexBCTHERESNOSUBSTRING.firstMatch(in: blankTypeDisplay, range: NSRange(location: 0, length: nsString.length))
                actualBlankDisplay = nsString.substring(with: mysteryObject!.range)
            } catch {
                print("F, part 3")
            }
            blanks[i] = (false, actualBlankDisplay,"")
        }
        
        title = lines[0]
        titleLength = title.components(separatedBy: NSCharacterSet.whitespacesAndNewlines).count
        completed = false
        key = ""
    }
    
    func fillBlank(position : Int, text : String){
        blanks[position]?.0 = true
        blanks[position]?.2 = text
    }
    
    func getTextAt(position : Int) -> String{
        return blanks[position]?.2 ?? "gg"
    }
    
    
    func getTypeOfPosition(pos : Int) -> String {
        return blanks[pos]?.1 ?? "something went wrong"
    }
    
    func getNumBlanks() -> Int {
        return blankTypes.count
    }
    
    func getFileName() -> String {
        return fileName
    }
    
    func isComplete() -> Bool {
        for i in 0..<blanks.count{
            if(blanks[i]!.0 == false){
                return false
            }
        }
        return true
    }
    
    func getFilledIndices() -> [Int] {
        var indices = [Int]()
        var actualIndex = titleLength
        var modifiedIndex = 0
        var currWord = String() 
        
        while actualIndex < words.count {
            currWord = words[actualIndex]
            if(words[actualIndex].hasPrefix("<")){
                indices.append(modifiedIndex)
                
                while(!currWord.contains(">")){
                    actualIndex += 1
                    currWord = words[actualIndex]
                }
            }
            
            modifiedIndex += 1
            actualIndex += 1

        }
        
        return indices
    }
    
    //hey, this is rough, but it works, so it's ok
    func getFullText() -> String{
        
        var blankIndex = 0;
        var currWord : String
        var completeString = "";
        
        var i = titleLength
        while i < words.count{
            currWord = words[i]
            
            if (currWord.hasPrefix("<")){
                
                completeString += " " + (blanks[blankIndex]?.2)!
                blankIndex += 1
                
                while(!currWord.contains(">")){
                    i += 1
                    currWord = words[i]
                }
                
                if(currWord.hasSuffix(".") || currWord.hasSuffix(";") || currWord.hasSuffix("!") || currWord.hasSuffix(",")){
                    completeString += currWord.suffix(1)
                }
                
            } else {
                completeString += " " + currWord
            }
            i += 1
        }
        return completeString
    }
    
    func saveMaybe(key : String){
        var types = [Int:String]()
        var toBlanks = [Int:String]()
        
        for (index, data) in blanks {
            types[index] = data.1
            toBlanks[index] = data.2
        }
        
        let saveMe = inProgressLib(key: key, fileName: fileName, blankTexts: toBlanks)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(saveMe) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
}

/*BEFORE I FUCKING FORGET:
when you hit save - Userdefaults has: key -> filename, data on blanks
 Userdefaults also needs list of saved [key, filename]
 will display on saved screen by key
 when you click on it, ---> create lib will load NEW LIB from associated filename
                            then like, it will load FROM USERDEFAULTS the blanks to display
                            then display ---> then should work as normal
 
*/

struct inProgressLib : Codable {
    var key : String
    var fileName : String
    var blankTexts : [Int:String]
}

class LIBModel {
    let catagories = [String:[madlib]]()
}

