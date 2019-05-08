//
//  InProgressLibsViewController.swift
//  The Liberator
//
//  Created by Allison Wei on 5/6/19.
//  Copyright © 2019 Chase Wooten. All rights reserved.
//

import UIKit

class InProgressCell : UITableViewCell {
    @IBOutlet weak var keyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class InProgressLibsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    var inProgressLibs = [String:String]()
    var selectedKey = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        if let libs = UserDefaults.standard.value(forKey: "LibsInProgress") as? [String:String] {
            inProgressLibs = libs
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
        return inProgressLibs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "keyCell", for: indexPath) as! InProgressCell
        cell.keyLabel.text = Array(inProgressLibs)[indexPath.row].key
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedKey = Array(inProgressLibs)[indexPath.row].key
        self.performSegue(withIdentifier: "toReCreate", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toReCreate" {
            if let destinationVC = segue.destination as? CreateLibViewController {
                
                //need to manually reload the lib!
                var lib = madlib()
                
                if let keyAndFile = UserDefaults.standard.value(forKey: "LibsInProgress") as? [String : String] {
                    if let file = keyAndFile[selectedKey]{
                        lib = madlib(fileName: file)
                        lib.key = selectedKey
                    }
                }
                
                if let savedLib = UserDefaults.standard.value(forKey: selectedKey) as? Data {
                    let decoder = JSONDecoder()
                    if let loadedLib = try? decoder.decode(inProgressLib.self, from: savedLib) {
                        for i in 0..<lib.getNumBlanks(){
                            if let text = loadedLib.blankTexts[i] {
                                lib.fillBlank(position: i, text: text)
                            }
                        }
                    }
                }
                
                destinationVC.lib = lib
            }
        }
    }

    

}
