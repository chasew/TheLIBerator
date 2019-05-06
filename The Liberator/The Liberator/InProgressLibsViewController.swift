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
    
    var inProgressLibs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        if let libs = UserDefaults.standard.value(forKey: "LibsInProgress") as? [String] {
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
        cell.keyLabel.text = inProgressLibs[indexPath.row]
        print("shit should say \(inProgressLibs[indexPath.row])")
        return cell
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
