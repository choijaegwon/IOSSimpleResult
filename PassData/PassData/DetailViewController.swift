//
//  DetailViewController.swift
//  PassData
//
//  Created by Jae kwon Choi on 2021/11/04.
//

import UIKit

class DetailViewController: UIViewController {
    
    var someString = ""

    @IBOutlet weak var someLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        someLabel.text = someString
    }

}
