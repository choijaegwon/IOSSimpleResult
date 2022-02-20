//
//  ViewController.swift
//  CustomKeyboard_Not_Extension
//
//  Created by Jae kwon Choi on 2022/02/18.
//

import UIKit

class ViewController: UIViewController, CustomKeyboardDelgate {

    @IBOutlet weak var firstTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 커스텀 키보드 설정 방법
        // firstTextField.inputView = "커스텀 키보드 뷰"
        
        let loadNib = Bundle.main.loadNibNamed("CustomKeyboard", owner: nil, options: nil)
        
        let mykeyboardView = loadNib?.first as! CustomKeyboard
        mykeyboardView.delegate = self
        firstTextField.inputView = mykeyboardView
    }
    
    func keyboardTapped(str: String) {
        // 키보드를 눌렀을 때 호출 됨
        
        //타입변환이 필요하다
        let oldNumber = Int(firstTextField.text!)
        var newNumber = Int(str)
        
        if str == "0" && oldNumber != nil {
            newNumber = oldNumber! * 10
        }
        
        if str == "00" && oldNumber != nil {
            newNumber = oldNumber! * 100
        }
        
        if str == "000" && oldNumber != nil {
            newNumber = oldNumber! * 1000
        }
        
        if let hasNumber = newNumber {
            
            let numberFormatter = NumberFormatter()
            //3자리마다 표시해라
            numberFormatter.numberStyle = .decimal
            if let formatted = numberFormatter.string(from: NSNumber(value: hasNumber)) {
            firstTextField.text = String(describing: formatted)
            }
        }
        
    }


}

