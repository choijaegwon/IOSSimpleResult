//
//  CustomKeyboard.swift
//  CustomKeyboard_Not_Extension
//
//  Created by Jae kwon Choi on 2022/02/20.
//

import UIKit

// delegate - 기능, 값 위임
protocol CustomKeyboardDelgate {
    func keyboardTapped(str: String)
}

class CustomKeyboard: UIView {
    
    var delegate: CustomKeyboardDelgate?

    @IBAction func buttonTapped(_ sender: UIButton) {
        
        delegate?.keyboardTapped(str: sender.titleLabel!.text!)
        
        
        
    }

}
