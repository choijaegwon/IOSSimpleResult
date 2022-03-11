//
//  InstanceDetailViewController.swift
//  PassData
//
//  Created by Jae kwon Choi on 2021/11/05.
//

import UIKit

class InstanceDetailViewController: UIViewController {
    
    var mainVC: ViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func sendDataMainVc(_ sender: Any) {
        mainVC?.dataLabel.text = "some data"
        self.dismiss(animated: true, completion: nil)
    }

}
