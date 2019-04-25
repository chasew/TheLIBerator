//
//  CategoriesViewController.swift
//  The Liberator
//
//  Created by Tsipora Stone on 4/24/19.
//  Copyright © 2019 Chase Wooten. All rights reserved.
//

import Foundation
import UIKit

class customCell: UICollectionViewCell {
    
}
class CategoriesViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        tap.delegate = (self as! UIGestureRecognizerDelegate)
        collectionView?.addGestureRecognizer(tap)
    }
    
    @IBOutlet weak var categories: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    let reuseIdentifier = "customCell"
    
    @objc func didTap(sender: UITapGestureRecognizer) {
        // go to the madlib after tapped
        // not really sure how to do this part I guess it would have to call the model where it decides which madlab to choose based on the category?
        print("tapped")
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}
