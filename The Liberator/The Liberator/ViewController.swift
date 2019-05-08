//
//  ViewController.swift
//  The Liberator
//
//  Created by Chase Wooten on 4/22/19.
//  Copyright © 2019 Chase Wooten and Allison Wei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var NewButton: UIButton!
    @IBOutlet weak var ProgressButton: UIButton!
    @IBOutlet weak var ViewButton: UIButton!
    @IBOutlet weak var VoiceSettingsButton: UIButton!
    @IBOutlet weak var randomButton: UIButton!
    
    var randomWordsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"Startup")!)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "Startup")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        NewButton.layer.cornerRadius = 10
        NewButton.layer.borderWidth = 3
        NewButton.layer.backgroundColor = UIColor(red: 0.6863, green: 0.8314, blue: 1, alpha: 1.0).cgColor
        NewButton.layer.borderColor = UIColor(red: 0.251, green: 0.098, blue: 0.8196, alpha: 1.0).cgColor
        NewButton.setTitleColor(UIColor(red: 0.251, green: 0.098, blue: 0.8196, alpha: 1.0), for: UIControl.State.normal)
        
        randomButton.layer.cornerRadius = 10
        randomButton.layer.borderWidth = 3
        randomButton.layer.backgroundColor = UIColor(red: 0.6863, green: 0.8314, blue: 1, alpha: 1.0).cgColor
        randomButton.layer.borderColor = UIColor(red: 0.251, green: 0.098, blue: 0.8196, alpha: 1.0).cgColor
        randomButton.setTitleColor(UIColor(red: 0.251, green: 0.098, blue: 0.8196, alpha: 1.0), for: UIControl.State.normal)
        
        ProgressButton.layer.cornerRadius = 10
        ProgressButton.layer.borderWidth = 3
        ProgressButton.layer.backgroundColor = UIColor(red: 0.6863, green: 0.8314, blue: 1, alpha: 1.0).cgColor
        ProgressButton.layer.borderColor = UIColor(red: 0.251, green: 0.098, blue: 0.8196, alpha: 1.0).cgColor
        ProgressButton.setTitleColor(UIColor(red: 0.251, green: 0.098, blue: 0.8196, alpha: 1.0), for: UIControl.State.normal)
        
        ViewButton.layer.cornerRadius = 10
        ViewButton.layer.borderWidth = 3
        ViewButton.layer.backgroundColor = UIColor(red: 0.6863, green: 0.8314, blue: 1, alpha: 1.0).cgColor
        ViewButton.layer.borderColor = UIColor(red: 0.251, green: 0.098, blue: 0.8196, alpha: 1.0).cgColor
        ViewButton.setTitleColor(UIColor(red: 0.251, green: 0.098, blue: 0.8196, alpha: 1.0), for: UIControl.State.normal)
        
        VoiceSettingsButton.layer.cornerRadius = 10
        VoiceSettingsButton.layer.borderWidth = 3
        VoiceSettingsButton.layer.backgroundColor = UIColor(red: 0.6863, green: 0.8314, blue: 1, alpha: 1.0).cgColor
        VoiceSettingsButton.layer.borderColor = UIColor(red: 0.251, green: 0.098, blue: 0.8196, alpha: 1.0).cgColor
        VoiceSettingsButton.setTitleColor(UIColor(red: 0.251, green: 0.098, blue: 0.8196, alpha: 1.0), for: UIControl.State.normal)
        
        //setting default pitch settings :) 
        if (UserDefaults.standard.value(forKey: "PitchSettings") as? [String:Float]) == nil {
            let settings = [
                "pitch" : 0.5,
                "volume" : 0.5,
                "rate" : 0.5
            ]
            UserDefaults.standard.set(settings, forKey: "PitchSettings")
        }
        
        if (UserDefaults.standard.value(forKey: "Language") as? String) == nil {
            UserDefaults.standard.set("English", forKey: "Language")
        }
        
        do {
            if let path = Bundle.main.path(forResource: "randomWords", ofType: "txt"){
                let all = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                randomWordsArray = all.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
            }
        } catch _ as NSError {
            print("F")
        }
    }
    
    let fileMap = [
        "Camping": ["Camping"],
        "Love": ["Love Letter 3", "Love Letter 4","love"],
        "Holidays": ["christmasLib","holiday","shamrocks"],
        "One Liners": ["bus","chicken","donut","flipFlops"],
        "Funny": ["bbq","hotDog","late","speech","Dream Man"],
        "Misc": ["locker","road","vacuum",]
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("toRandomFinished")
        if segue.identifier == "toRandomFinished" {
            
            let randomC = Int.random(in: 0..<fileMap.count)
            
            let catagory = Array(fileMap)[randomC].key
            let libs = fileMap[catagory]
            let randomIndex = Int.random(in: 0..<libs!.count)
            
            let file = libs![randomIndex]
            print(file)
            let lib = madlib(fileName: file)
            lib.key = "Random Lib"
            
            
            var randomNum = Int() 
            for i in 0..<lib.getNumBlanks() {
                randomNum = Int.random(in: 0..<500)
                lib.fillBlank(position: i, text: randomWordsArray[randomNum])
            }
            
            if let vc = segue.destination as? FinishedLibViewController {
                vc.text = lib.getFullText()
                vc.lib = lib
            }
        }
    }


}

