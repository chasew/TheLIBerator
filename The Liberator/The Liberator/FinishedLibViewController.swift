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
    
    var text = String()
    let synthesizer = AVSpeechSynthesizer()
    var savedPitch = Float()
    var savedVolume = Float()
    var savedRate = Float()
    
    
    @IBOutlet weak var textView: UITextView!
     var lib : madlib?
    @IBOutlet weak var speak: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = text
        textView.font = .preferredFont(forTextStyle: .body)
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
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"PurpleBG")!)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "PurpleBG")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
    }
    
    @IBAction func speakButton(_ sender: UIButton) {
        let vc = VoiceSettingViewController()
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = vc.savedRate
        utterance.pitchMultiplier = vc.savedPitch
        utterance.volume = vc.savedVolume
        print(vc.savedRate)
        print(vc.savedPitch)
        print(vc.savedVolume)
        synthesizer.speak(utterance)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
