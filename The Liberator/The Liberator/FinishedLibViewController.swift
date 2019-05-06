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
        var words = text.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        let attributedString = NSMutableAttributedString.init(string: text)
        for index in indices {
            let range = (text as NSString).range(of: words[index - 1])
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: range)
            attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 15), range: range)
            print(range)
            print(words[index])
            textView.attributedText = attributedString
            textView.isUserInteractionEnabled = false
            textView.isEditable = false
        }
        
    }
    
    
    @IBAction func speakButton(_ sender: UIButton) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
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
