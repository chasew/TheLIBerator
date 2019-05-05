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
    
    let catagories = ["christmashehe", "christmasLib", "Cata 3", "Cata 4", "Cata 5", "Cata 6"]
    
    let catagoryImages: [UIImage] = [
        UIImage(named: "holidaze")!,
        UIImage(named: "holidaze")!,
        UIImage(named: "holidaze")!,
        UIImage(named: "holidaze")!,
        UIImage(named: "holidaze")!,
        UIImage(named: "holidaze")!
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
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
                //change this as such to give it a file name after you know what is selected,,,
                destinationVC.libFileName = selected
            }
        }
    }
    

}
