//
//  LIBmodel.model.swift
//  The Liberator
//
//  Created by Chase Wooten on 4/22/19.
//  Copyright © 2019 Chase Wooten. All rights reserved.
//

import Foundation

// defining the constants for our blank spaces
// these are subject to change not sure what kind of blanks we want
let NOUN = "BLNKN"
let ADJ = "BLNKA"
let VERB = "BLNKV"
let PERSON = "BLNKP"



class madlib {
    var title = String()
    var story = [String()]
    var allblank = Bool()
    var dictionary =  [Int: (Bool, String, String)]()
    
    

    init(title: String, story: [String]) {
        self.title = title
        self.story = story
        self.allblank = false
        self.dictionary = [Int: (Bool, String, String)]()
        
        // just itterating through the story and checking for blanks to add to the dictionary
        for i in 0 ..< story.count {
            switch story[i] {
            case NOUN: // assigned to false for not filled, type noun, and empty string for empty lol
                self.dictionary[i] = (false, NOUN, "")
            case ADJ:
                self.dictionary[i] = (false, ADJ, "")
            case VERB:
                self.dictionary[i] = (false, VERB, "")
            case ADJ:
                self.dictionary[i] = (false, VERB, "")
            default:
                print("this isnt a blank") // it made me do something here we should change this later
            }
        }
    }
    
    
}
    
    
    
    
    

    

