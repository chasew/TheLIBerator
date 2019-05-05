//
//  CreateLibViewController.swift
//  The Liberator
//
//  Created by Tsipora Stone on 4/24/19.
//  Copyright © 2019 Chase Wooten. All rights reserved.
//

import UIKit

class InputCell: UITableViewCell {
    
    
    @IBOutlet weak var inputType: UILabel!
    @IBOutlet weak var inputField: UITextField!
    @IBAction func inputAction(_ sender: Any) {
        inputField.becomeFirstResponder()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class CreateLibViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //will be passed via Catagory Selection Screen so should always exist
    var libFileName : String?
    var lib : madlib?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let file = libFileName {
            lib = madlib(fileName: file)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lib!.getNumBlanks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath) as! InputCell
        cell.inputType.text = lib?.getTypeOfPosition(pos: indexPath.item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.item)
        let cell = tableView.cellForRow(at: indexPath) as! InputCell
        cell.inputField.becomeFirstResponder()
    }
    

}
