//
//  VoiceSettingViewController.swift
//  The Liberator
//
//  Created by Tsipora Stone on 5/6/19.
//  Copyright © 2019 Chase Wooten. All rights reserved.
//

import UIKit

class VoiceSettingViewController: UIViewController {
    @IBOutlet weak var pitchSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var backButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"RedBlueBG")!)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "RedBlueBG")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        backButton.layer.cornerRadius = 10
        backButton.layer.borderWidth = 3
        backButton.layer.backgroundColor = UIColor(red: 0.8745, green: 0.8275, blue: 1, alpha: 1.0).cgColor
        backButton.layer.borderColor = UIColor(red: 0.2824, green: 0, blue: 1, alpha: 1.0).cgColor
        backButton.setTitleColor(UIColor(red: 0.2824, green: 0, blue: 1, alpha: 1.0), for: UIControl.State.normal)
        
        if let settings = UserDefaults.standard.value(forKey: "PitchSettings") as? [String:Float] {
            pitchSlider.value = settings["pitch"]!
            volumeSlider.value = settings["volume"]!
            rateSlider.value = settings["rate"]!
            
        }
        
    }
    
    @IBAction func pitchValueChanged(_ sender: UISlider) {
        changeSetting(setting: "pitch", value: sender.value)
    }
    
    @IBAction func volumeValueChanged(_ sender: UISlider) {
        changeSetting(setting: "volume", value: sender.value)
    }
    
    @IBAction func rateValueChanged(_ sender: UISlider) {
        changeSetting(setting: "rate", value: sender.value)
    }
    
    func changeSetting(setting : String, value: Float){
        if var settings = UserDefaults.standard.value(forKey: "PitchSettings") as? [String:Float] {
            settings[setting] = value
            UserDefaults.standard.set(settings, forKey: "PitchSettings")
        }
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
