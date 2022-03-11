//
//  DelegateDetailViewController.swift
//  PassData
//
//  Created by Jae kwon Choi on 2021/11/06.
//

import UIKit

protocol DelegateDetailViewControllerDelegate: AnyObject {
    
    //데이터를 넘겨주는 함수
    //정의만 있고 바디는 있으면 안됨.
    func passString(string: String)
}

class DelegateDetailViewController: UIViewController {

    weak var delegate: DelegateDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func passDataToMainVC(_ sender: Any) {
        delegate?.passString(string: "delegate pass Data")
        self.dismiss(animated: true, completion: nil)
    }
    

}
