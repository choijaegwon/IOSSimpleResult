//
//  FloatingButtonListViewController.swift
//  Floating_Button
//
//  Created by Jae kwon Choi on 2022/02/17.
//

import UIKit

class FloatingButtonListViewController: UIViewController {

    @IBOutlet weak var btn1CenterY: NSLayoutConstraint!
    @IBOutlet weak var btn2CenterY: NSLayoutConstraint!
    @IBOutlet weak var btn3CenterY: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn1CenterY.constant = 0
        btn2CenterY.constant = 0
        btn3CenterY.constant = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        UIView.animate(withDuration: 1) {
//            self.btn1CenterY.constant = 80
//            self.btn2CenterY.constant = 160
//            self.btn3CenterY.constant = 240
//
//            self.view.layoutIfNeeded()
//
//        }
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.btn1CenterY.constant = 80
            self.btn2CenterY.constant = 160
            self.btn3CenterY.constant = 240
            
            self.view.layoutIfNeeded()
            
        }) { (completion) in
            // 애니메이션이 끝나는 시점

        }

        
    }
    @IBAction func dismissFloating(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.btn1CenterY.constant = 0
            self.btn2CenterY.constant = 0
            self.btn3CenterY.constant = 0
            
            self.view.layoutIfNeeded()
            
        }) { (completion) in
            // 애니메이션이 끝나는 시점
            self.dismiss(animated: false, completion: nil)

        }
        
    }
    
}
