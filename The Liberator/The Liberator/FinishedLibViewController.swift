//
//  FinishedLibViewController.swift
//  The Liberator
//
//  Created by Tsipora Stone on 5/5/19.
//  Copyright © 2019 Chase Wooten. All rights reserved.
//

import UIKit
import AVFoundation

class FinishedLibViewController: UIViewController {
    
    var lib : madlib?
    var text = String()
    
    let synthesizer = AVSpeechSynthesizer()
    var savedPitch = Float()
    var savedVolume = Float()
    var savedRate = Float()
    let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var speak: UIButton!
    
    @IBOutlet weak var speakButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var TitleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = text
        textView.font = UIFont.systemFont(ofSize: 17.0)
        textView.adjustsFontForContentSizeCategory = true
        textView.center = self.view.center
        textView.textAlignment = NSTextAlignment.justified
        
        let indices = (lib?.getFilledIndices())!
        print("wtf? \(indices)")
        let words = text.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        
        let wordsUpdate = words.filter {$0 != ""}
        print(wordsUpdate)
        let attributedString = NSMutableAttributedString.init(string: text)
        for index in indices {
            let range = (text as NSString).range(of: wordsUpdate[index])
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: range)
            attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 12), range: range)
            //print(range)
            //print(words[index])
            textView.attributedText = attributedString
            textView.isUserInteractionEnabled = false
            textView.isEditable = false
        }
        
        textView.font = UIFont(name: textView.font!.fontName, size: 24)
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"PurpleBG")!)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "PurpleBG")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        speakButton.layer.cornerRadius = 10
        speakButton.layer.borderWidth = 3
        speakButton.layer.backgroundColor = UIColor(red: 0.8745, green: 0.8275, blue: 1, alpha: 1.0).cgColor
        speakButton.layer.borderColor = UIColor(red: 0.2824, green: 0, blue: 1, alpha: 1.0).cgColor
        speakButton.setTitleColor(UIColor(red: 0.2824, green: 0, blue: 1, alpha: 1.0), for: UIControl.State.normal)
        
        homeButton.layer.cornerRadius = 10
        homeButton.layer.borderWidth = 3
        homeButton.layer.backgroundColor = UIColor(red: 0.8745, green: 0.8275, blue: 1, alpha: 1.0).cgColor
        homeButton.layer.borderColor = UIColor(red: 0.2824, green: 0, blue: 1, alpha: 1.0).cgColor
        homeButton.setTitleColor(UIColor(red: 0.2824, green: 0, blue: 1, alpha: 1.0), for: UIControl.State.normal)
        
        print("SDFUIHWEFJ\(lib?.key)")
        if(lib?.key != ""){
            TitleButton.setTitle(lib?.key, for: .normal)
            
        } else {
            TitleButton.setTitle("  " + "Untitled  ", for: .normal)
        }
        
        TitleButton.layer.cornerRadius = 10
        TitleButton.layer.borderWidth = 3
        TitleButton.layer.backgroundColor = UIColor(red: 0.8471, green: 0.8902, blue: 1, alpha: 1.0).cgColor
        TitleButton.layer.borderColor = UIColor(red: 0.0392, green: 0.3098, blue: 1, alpha: 1.0).cgColor
        TitleButton.setTitleColor(UIColor(red: 0.0392, green: 0.3098, blue: 1, alpha: 1.0), for: UIControl.State.normal)
        
    }
    
    @IBAction func speakButton(_ sender: UIButton) {
        let utterance = AVSpeechUtterance(string: text)
        switch  (defaults.object(forKey:"Language") as? String)! {
        case "English":
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        case "Spanish":
            utterance.voice = AVSpeechSynthesisVoice(language: "es")
        case "Chinese":
            utterance.voice = AVSpeechSynthesisVoice(language: "zh-Hans")
        case "Hebrew":
            utterance.voice = AVSpeechSynthesisVoice(language: "he")
        default:
            print("hello")
        }
        
        if var settings = UserDefaults.standard.value(forKey: "PitchSettings") as? [String:Float] {
            utterance.rate = settings["rate"]!
            utterance.pitchMultiplier = settings["pitch"]!
            utterance.volume = settings["volume"]!
            
            print("RATE \(utterance.rate)")
            
        }
        
        synthesizer.speak(utterance)
    }
    

}
