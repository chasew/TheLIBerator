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
    
    let catagories = ["Cata 1", "Cata 2", "Cata 3", "Cata 4", "Cata 5", "Cata 6"]
    
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
        
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        
        return cell
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        
        if let item = indexPath?.item {
            print("\(catagories[item])")
        }
    }

}
