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
    
    var inProgressLibs = [String:String]()
    var selectedKey = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        if let libs = UserDefaults.standard.value(forKey: "LibsInProgress") as? [String:String] {
            inProgressLibs = libs
            print("Yo, i got sum \(libs)")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("how many tho: \(inProgressLibs.count)")
        return inProgressLibs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "keyCell", for: indexPath) as! InProgressCell
        cell.keyLabel.text = Array(inProgressLibs)[indexPath.row].key
        print("shit should say \(Array(inProgressLibs)[indexPath.row].key)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedKey = Array(inProgressLibs)[indexPath.row].key
        print(selectedKey)
        
//        let currentCell = tableView.cellForRow(at: indexPath) as! InProgressCell
//        if let text = currentCell.keyLabel!.text {
//            print("SELECTEDKEY \(selectedKey)")
//            selectedKey = text
//        }
        //self.performSegue(withIdentifier: "toReCreate", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toReCreate" {
            if let destinationVC = segue.destination as? CreateLibViewController {
                
                //need to manually reload the lib!
                
                //var lib = madlib(fileName: selectedKey)
                
                if let libData = UserDefaults.standard.value(forKey: selectedKey) as? Data {
                    let decoder = JSONDecoder()
                    if let loadedLib = try? decoder.decode(inProgressLib.self, from: libData){
                        print("I'VE LOADED: \(loadedLib.fileName)")
                    }
                }
                
                destinationVC.libFileName = selectedKey
            }
        }
    }

    

}
