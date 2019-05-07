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
    
    var savedPitch: Float = 0.5
    var savedVolume: Float = 0.5
    var savedRate: Float = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pitchValueChanged(_ sender: UISlider) {
        savedPitch = sender.value
       print("the beginning savedPitch is \(savedPitch)")
    }
    
    @IBAction func volumeValueChanged(_ sender: UISlider) {
        savedVolume = sender.value
        print("the beginning savedVolume is \(savedVolume)")
    }
    
    @IBAction func rateValueChanged(_ sender: UISlider) {
        savedRate = sender.value
        print("the beginning savedRate is \(savedRate)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFinished" {
            if let vc = segue.destination as? FinishedLibViewController {
                vc.savedPitch = savedPitch
                vc.savedVolume = savedVolume
                vc.savedRate = savedRate
                print("hello im here :))))")
            }
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
