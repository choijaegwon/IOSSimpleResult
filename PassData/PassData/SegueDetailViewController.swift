//
//  SegueDetailViewController.swift
//  PassData
//
//  Created by Jae kwon Choi on 2021/11/05.
//

import UIKit

class SegueDetailViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    
    var dataString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        dataLabel.text = dataString
        // Do any additional setup after loading the view.
    }

}
