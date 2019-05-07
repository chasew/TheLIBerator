//
//  ViewFinishedLibsController.swift
//  The Liberator
//
//  Created by Allison Wei on 5/7/19.
//  Copyright © 2019 Chase Wooten. All rights reserved.
//

import UIKit

class finishedTitleCell: UITableViewCell {
    @IBOutlet weak var keyLabel: UILabel!
    
}


class ViewFinishedLibsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    

    var finishedLibs = [String:String]()
    var selectedKey = String()
    var text = String()
    var file = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self 
        
        if let libs = UserDefaults.standard.value(forKey: "FinishedLibs") as? [String:String] {
            finishedLibs = libs
            print("INTERESTING \(finishedLibs)")
        }
        
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
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finishedLibs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "finishedKeyCell", for: indexPath) as! finishedTitleCell
        cell.keyLabel.text = Array(finishedLibs)[indexPath.row].key
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedKey = Array(finishedLibs)[indexPath.row].key
        self.performSegue(withIdentifier: "savedToFinished", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "savedToFinished" {
            if let destinationVC = segue.destination as? FinishedLibViewController {
                
                if let keyAndText = UserDefaults.standard.value(forKey: "FinishedLibs") as? [String : String] {
                    if let theText = keyAndText[selectedKey]{
                        text = theText
                    }
                }
                
                if let keyAndFile = UserDefaults.standard.value(forKey: "TitleToFileName") as? [String : String] {
                    if let theFile = keyAndFile[selectedKey]{
                        file = theFile
                    }
                }
                
                ///lollllll I'm so sorry 
                destinationVC.lib = madlib(fileName: file)
                destinationVC.text = text
            }
        }
    }
    
 
}
