//
//  MyIDUIViewController.swift
//  Setting_Clone_App
//
//  Created by Jae kwon Choi on 2021/11/15.
//

import UIKit

class MyIDUIViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!{
        didSet{
            nextButton.isEnabled = false
        }
    }
    @IBAction func doCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.addTarget(self, action: #selector(textFileDidChange), for: .editingChanged)
        
    }
    
    @objc func textFileDidChange(sender: UITextField) {
        
        if sender.text?.isEmpty == true {
            nextButton.isEnabled = false
        }else{
            nextButton.isEnabled = true
        }
    }
}
