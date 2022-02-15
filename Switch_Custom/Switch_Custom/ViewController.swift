//
//  ViewController.swift
//  Switch_Custom
//
//  Created by Jae kwon Choi on 2022/02/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var switchBtn: UIButton!
    @IBOutlet weak var switchBG: UIView!
    @IBOutlet weak var buttonCenterX: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchBtn.layer.cornerRadius = 50 / 2
        switchBG.layer.cornerRadius = 50 / 2
        
        
    }
    
    @IBAction func sselectedButton(_ sender: Any) {
        
        if buttonCenterX.constant == 75 {
            buttonCenterX.constant = -75
            switchBG.backgroundColor = UIColor.lightGray
            
        }else{
            buttonCenterX.constant = 75
            switchBG.backgroundColor = UIColor.yellow
        }
     
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }


}

