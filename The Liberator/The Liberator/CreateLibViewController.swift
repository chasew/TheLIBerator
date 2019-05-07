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
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    @IBOutlet weak var spaceView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    var keyTextField: UITextField?
    
    @IBAction func SaveButton(_ sender: Any) {
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
                
                //adding key to list of keys (i.e. adding story "title" to list of in progress stories)
                if var libs = UserDefaults.standard.value(forKey: "LibsInProgress") as? [String:String] {
                    libs[key] = self.lib?.getFileName()
                    UserDefaults.standard.set(libs, forKey: "LibsInProgress")
                    print("I'm saving \(libs)")
                } else {
                    var libs = [String:String]()
                    libs[key] = self.lib?.getFileName()
                    UserDefaults.standard.set(libs, forKey: "LibsInProgress")
                    print("I'm saving \(libs)")
                }
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
        if let fullText = lib?.getFullText(){
            print(fullText)
        }
    }
    

    @IBAction func FinishButton(_ sender: Any) {
        if lib?.isComplete() == false {
            let alert = UIAlertController(title: "Not Complete!", message: "Must fill in all the blanks to see your madlib or press save progress to come back to it later", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in

            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let file = libFileName {
            lib = madlib(fileName: file)
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
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification: notification)
        print("yeah")
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification: notification)
        print("yeet")
    }
    
    //wowowow the keyboard doesn't cover shit anymore BLESSED
    func updateBottomLayoutConstraintWithNotification(notification: NSNotification){
        let userInfo = notification.userInfo!
        let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
        let rawAnimationCurve = (notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber).uint32Value << 16
        let animationCurve = UIView.AnimationOptions.init(rawValue: UInt(rawAnimationCurve))
        
        print("before: \(bottomSpace.constant)")
        bottomSpace.constant = view.bounds.maxY - convertedKeyboardEndFrame.minY
        print("after: \(bottomSpace.constant)")
        
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
