//
//  FinishedLibViewController.swift
//  The Liberator
//
//  Created by Tsipora Stone on 5/5/19.
//  Copyright © 2019 Chase Wooten. All rights reserved.
//

import UIKit

class FinishedLibViewController: UIViewController {
    
    var text = String()
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = text
        textView.font = .preferredFont(forTextStyle: .body)
        textView.adjustsFontForContentSizeCategory = true
        textView.center = self.view.center
        textView.textAlignment = NSTextAlignment.justified
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
