//
//  ViewController.swift
//  SignIn
//
//  Created by Jae kwon Choi on 2022/02/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    var emailErrorHeight: NSLayoutConstraint!
    var passwordErrorHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // textfield 값이 변경되는걸 캐치해주는게 없음
        emailTextField.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
        
        emailErrorHeight = emailError.heightAnchor.constraint(equalToConstant: 0)
        passwordErrorHeight = passwordError.heightAnchor.constraint(equalToConstant: 0)
        
    }
    
    @objc
    func textFieldEdited(textField: UITextField) {
        
        if textField == emailTextField{
            
            if isValidEmail(email: textField.text) == true{
                // 에러표시 안나와야 함.
                emailErrorHeight.isActive = true
                
            }else{
                emailErrorHeight.isActive = false
            }
            
            
        }else if textField == passwordTextField{
            if isValidPassword(pw: textField.text) == true{
                passwordErrorHeight.isActive = true
            }else{
                passwordErrorHeight.isActive = false
            }
        }
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
        
    }

    // 정규식 - regular expression
    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    func isValidPassword(pw:String?) -> Bool {
        if let hasPassword = pw{
            if hasPassword.count < 8{
                return false
            }
        }
        
        return true
    }

}

