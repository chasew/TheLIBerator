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

//NOTES: you want to be able to delete the thing you saved when you finish it
//like, if something is saved and you finish, you don't need to give it a title
//

class CreateLibViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    //will be passed via Catagory Selection Screen so should always exist
    var libFileName : String?
    var lib : madlib?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    @IBOutlet weak var spaceView: UIView!

    @IBOutlet weak var TitleButton: UIButton!
    

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    var keyTextField: UITextField?
    var finishedKeyTextField: UITextField?
    
    @IBAction func SaveButton(_ sender: Any) {
        //SAVE NEW
        if(lib?.key == "") {
            let alert = UIAlertController(title: "Save Progress", message: "Enter a title for your madlib", preferredStyle: .alert)
            alert.addTextField(configurationHandler: {(textField: UITextField) -> Void in
                self.keyTextField = textField
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in }))
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) -> Void in
                
                //need to add "if contains key don't fucking add" part here
                
                
                if let key = self.keyTextField?.text{
                    //saving the actual thing
                    self.lib?.saveMaybe(key: key)
                    self.lib!.key = key
                    
                    //adding key to list of keys (i.e. adding story "title" to list of in progress stories)
                    if var libs = UserDefaults.standard.value(forKey: "LibsInProgress") as? [String:String] {
                        libs[key] = self.lib?.getFileName()
                        UserDefaults.standard.set(libs, forKey: "LibsInProgress")
                    } else {
                        var libs = [String:String]()
                        libs[key] = self.lib?.getFileName()
                        UserDefaults.standard.set(libs, forKey: "LibsInProgress")
                    }
                }
                self.performSegue(withIdentifier: "createToHome", sender: self)
            }))
            self.present(alert, animated: true, completion: nil)
        
        } else { //ALREADY SAVED LOL
            let alert = UIAlertController(title: "Save Progress", message: "Saving \"\(lib!.key)\"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in }))
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) -> Void in
                if let oldKey = self.lib?.key {
                    self.lib?.saveMaybe(key: oldKey)
                }
                self.performSegue(withIdentifier: "createToHome", sender: self)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    

    @IBAction func FinishButton(_ sender: Any) {
        if lib?.isComplete() == false {
            let alert = UIAlertController(title: "Not Complete!", message: "Must fill in all the blanks to see your madlib or press save progress to come back to it later", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in

            }))
            self.present(alert, animated: true, completion: nil)
        } else {
 
            //YO, U HAVE TO SAVE IT LOLOLOLOLOL
            
            if(lib?.key == ""){
                let alert = UIAlertController(title: "Finish", message: "Enter a title for your madlib", preferredStyle: .alert)
                alert.addTextField(configurationHandler: {(textField: UITextField) -> Void in
                    self.finishedKeyTextField = textField
                })
                alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in }))
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) -> Void in
                    //have not saved before; must enter key
                    if let key = self.finishedKeyTextField?.text {
                        self.lib?.key = key
                        self.saveFinishedLib(key: key)
                    }
                    self.performSegue(withIdentifier: "toFinished", sender: self)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                //have already saved, just go to finish
                if let key = self.lib?.key{
                    self.saveFinishedLib(key: key)
                }
                self.performSegue(withIdentifier: "toFinished", sender: self)
            }
        }
    }
    
    func saveFinishedLib(key : String){
        //delete the "in progress" version of the lib when you finish thx
        if (UserDefaults.standard.value(forKey: key) as? Data) != nil {
            UserDefaults.standard.removeObject(forKey: key)
            if var keyAndFile = UserDefaults.standard.value(forKey: "LibsInProgress") as? [String : String] {
                keyAndFile.removeValue(forKey: key)
                UserDefaults.standard.set(keyAndFile, forKey: "LibsInProgress")
            }
            UserDefaults.standard.synchronize()
            
        }
        
        //time to save to userDefaults
        if var libs = UserDefaults.standard.value(forKey: "FinishedLibs") as? [String:String] {
            libs[key] = self.lib?.getFullText()
            UserDefaults.standard.set(libs, forKey: "FinishedLibs")
        } else {
            var libs = [String:String]()
            libs[key] = self.lib?.getFullText()
            UserDefaults.standard.set(libs, forKey: "FinishedLibs")
        }
        
        //lol, when you're too lazy to make one big thing so you make two small things
        if var titles = UserDefaults.standard.value(forKey: "TitleToFileName") as? [String:String] {
            titles[key] = self.lib?.getFileName()
            UserDefaults.standard.set(titles, forKey: "TitleToFileName")
        } else {
            var titles = [String:String]()
            titles[key] = self.lib?.getFileName()
            UserDefaults.standard.set(titles, forKey: "TitleToFileName")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let file = libFileName {
            lib = madlib(fileName: file)
        }
        
        if(lib?.key != ""){
            TitleButton.setTitle(lib?.key, for: .normal)
            
        }
        else {
            TitleButton.setTitle("  " + "New Madlib  ", for: .normal)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"YellowBG")!)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "YellowBG")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        backButton.layer.cornerRadius = 10
        backButton.layer.borderWidth = 3
        backButton.layer.backgroundColor = UIColor(red: 1, green: 0.9216, blue: 0.749, alpha: 1.0).cgColor
        backButton.layer.borderColor = UIColor(red: 1, green: 0.498, blue: 0, alpha: 1.0).cgColor
        backButton.setTitleColor(UIColor(red: 1, green: 0.498, blue: 0, alpha: 1.0), for: UIControl.State.normal)
        
        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderWidth = 3
        saveButton.layer.backgroundColor = UIColor(red: 1, green: 0.9216, blue: 0.749, alpha: 1.0).cgColor
        saveButton.layer.borderColor = UIColor(red: 1, green: 0.498, blue: 0, alpha: 1.0).cgColor
        saveButton.setTitleColor(UIColor(red: 1, green: 0.498, blue: 0, alpha: 1.0), for: UIControl.State.normal)
        
        finishButton.layer.cornerRadius = 10
        finishButton.layer.borderWidth = 3
        finishButton.layer.backgroundColor = UIColor(red: 1, green: 0.9216, blue: 0.749, alpha: 1.0).cgColor
        finishButton.layer.borderColor = UIColor(red: 1, green: 0.498, blue: 0, alpha: 1.0).cgColor
        finishButton.setTitleColor(UIColor(red: 1, green: 0.498, blue: 0, alpha: 1.0), for: UIControl.State.normal)
        
        TitleButton.layer.cornerRadius = 10
        TitleButton.layer.borderWidth = 3
        TitleButton.layer.backgroundColor = UIColor(red: 0.8471, green: 0.8902, blue: 1, alpha: 1.0).cgColor
        TitleButton.layer.borderColor = UIColor(red: 0.0392, green: 0.3098, blue: 1, alpha: 1.0).cgColor
        TitleButton.setTitleColor(UIColor(red: 0.0392, green: 0.3098, blue: 1, alpha: 1.0), for: UIControl.State.normal)
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification: notification)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification: notification)
    }
    
    //wowowow the keyboard doesn't cover shit anymore BLESSED
    func updateBottomLayoutConstraintWithNotification(notification: NSNotification){
        let userInfo = notification.userInfo!
        let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
        let rawAnimationCurve = (notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber).uint32Value << 16
        let animationCurve = UIView.AnimationOptions.init(rawValue: UInt(rawAnimationCurve))
        
        bottomSpace.constant = view.bounds.maxY - convertedKeyboardEndFrame.minY
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.beginFromCurrentState, animationCurve], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
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
        cell.inputField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        return cell
        
    }

    //BOYYY THIS INEFFICIENT BUT IT WORKS :)
    @objc func textFieldDidChange(_ textField: UITextField) {
        if(textField.text! != ""){
            lib?.fillBlank(position: textField.tag, text: textField.text!)
        }
    }
    
    //you can hit enter to "stop typing" lol
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFinished" {
            if let vc = segue.destination as? FinishedLibViewController {
                vc.text = (lib?.getFullText())!
                vc.lib = lib
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! InputCell
        cell.inputField.resignFirstResponder()
    }
    
}
