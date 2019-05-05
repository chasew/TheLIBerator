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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"Startup")!)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "Startup")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        NewButton.layer.cornerRadius = 10
        NewButton.layer.borderWidth = 0
        NewButton.layer.backgroundColor = UIColor(red: 0.6863, green: 0.8314, blue: 1, alpha: 1.0).cgColor
        NewButton.layer.borderColor = UIColor(red: 0.251, green: 0.098, blue: 0.8196, alpha: 1.0).cgColor
        NewButton.setTitleColor(UIColor(red: 0.251, green: 0.098, blue: 0.8196, alpha: 1.0), for: UIControl.State.normal)
        
        ProgressButton.layer.cornerRadius = 10
        ProgressButton.layer.borderWidth = 0
        ProgressButton.layer.backgroundColor = UIColor(red: 0.6863, green: 0.8314, blue: 1, alpha: 1.0).cgColor
        ProgressButton.layer.borderColor = UIColor(red: 0.251, green: 0.098, blue: 0.8196, alpha: 1.0).cgColor
        ProgressButton.setTitleColor(UIColor(red: 0.251, green: 0.098, blue: 0.8196, alpha: 1.0), for: UIControl.State.normal)
        
        ViewButton.layer.cornerRadius = 10
        ViewButton.layer.borderWidth = 0
        ViewButton.layer.backgroundColor = UIColor(red: 0.6863, green: 0.8314, blue: 1, alpha: 1.0).cgColor
        ViewButton.layer.borderColor = UIColor(red: 0.251, green: 0.098, blue: 0.8196, alpha: 1.0).cgColor
        ViewButton.setTitleColor(UIColor(red: 0.251, green: 0.098, blue: 0.8196, alpha: 1.0), for: UIControl.State.normal)
    }


}

