//
//  VoiceSettingViewController.swift
//  The Liberator
//
//  Created by Tsipora Stone on 5/6/19.
//  Copyright © 2019 Chase Wooten. All rights reserved.
//

import UIKit

class VoiceSettingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pitchSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var languagesPicker: UIPickerView!
    var pickerData : [String] = [String]()
    let defaults = UserDefaults.standard
//    var language = String()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (UserDefaults.standard.value(forKey: "Language") as? String) != nil{
            UserDefaults.standard.set(pickerData[row], forKey: "Language")
        }
        return pickerData[row]
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pickerData = ["American", "Spanish - Mexico", "Chinese - simplified", "Hebrew"]
        self.languagesPicker.delegate = self
        self.languagesPicker.dataSource = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"voicesettingBG")!)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "voicesettingBG")?.draw(in: self.view.bounds)
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
