//
//  ViewController.swift
//  Floating_Button
//
//  Created by Jae kwon Choi on 2022/02/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPopup" {
            let floatingVC = segue.destination as! FloatingButtonListViewController
            
            //배경투명하게하기
            floatingVC.modalPresentationStyle = .overCurrentContext
            
        }
    }
    
}

