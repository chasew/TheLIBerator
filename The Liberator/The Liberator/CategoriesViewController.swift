//
//  CategoriesViewController.swift
//  The Liberator
//
//  Created by Tsipora Stone on 4/24/19.
//  Copyright © 2019 Chase Wooten. All rights reserved.
//

import Foundation
import UIKit

class CategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selected = String()
    
    let catagories = ["Camping", "Love", "Holidays", "One Liners", "Funny", "Misc"]
    
    //catagory -> list of libs 
    let fileMap = ["Camping": ["Yeah"],
                   "Love": ["Yeah"],
                   "Holidays": ["Yeah"],
                   "One Liners": ["Yeah"],
                   "Funny": ["Yeah"],
                   "Misc": ["Yeah"],]
    
    let catagoryImages: [UIImage] = [
        UIImage(named: "camping")!,
        UIImage(named: "love")!,
        UIImage(named: "holidaze")!,
        UIImage(named: "oneline")!,
        UIImage(named: "funny")!,
        UIImage(named: "misc")!
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
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
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catagories.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CatagoryCell
        cell.catagoryLabel.text = catagories[indexPath.item]
        cell.catagoryImage.image = catagoryImages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        //selected is a catagory
        selected = catagories[indexPath.item]
        self.performSegue(withIdentifier: "toCreate", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreate" {
            if let destinationVC = segue.destination as? CreateLibViewController {
                //YOU NEED TO GIVE IT A FILENAME HERE OK
                destinationVC.libFileName = "Camping"
            }
        }
    }
    

}
