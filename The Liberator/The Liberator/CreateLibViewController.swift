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
       // inputField.becomeFirstResponder()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    
}

class CreateLibViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    //will be passed via Catagory Selection Screen so should always exist
    var libFileName : String?
    var lib : madlib?

    @IBOutlet weak var tableView: UITableView!
    
    var keyTextField: UITextField?
    
    @IBAction func SaveButton(_ sender: Any) {
        let alert = UIAlertController(title: "Save Progress", message: "Enter a title for your madlib", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField: UITextField) -> Void in
            self.keyTextField = textField
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in }))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) -> Void in
            if let key = self.keyTextField?.text{
                print(key)
            }
        }))
        self.present(alert, animated: true, completion: nil)
        if let fullText = lib?.getFullText(){
            print(fullText)
        }
    }
    

    @IBAction func FinishButton(_ sender: Any) {
   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let file = libFileName {
            lib = madlib(fileName: file)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                print("wtf")
                self.view.frame.origin.y = -keyboardSize.height
                tableView.frame.origin.y += keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        tableView.frame.origin.y = 123
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
        
        //this three lines of code...was...not worth it...
        cell.inputField.delegate = self
        cell.inputField.text = lib?.getTextAt(position: indexPath.row) //filling from model
        cell.inputField.tag = indexPath.row
        
        return cell
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        //this is essentially auto-save, you're welcome
        if(textField.text! != ""){
            lib?.fillBlank(position: textField.tag, text: textField.text!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFinished" {
            if let vc = segue.destination as? FinishedLibViewController {
                vc.text = (lib?.getFullText())!
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! InputCell
        cell.inputField.resignFirstResponder()
    }
    
}
