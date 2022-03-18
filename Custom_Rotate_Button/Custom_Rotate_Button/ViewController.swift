//
//  ViewController.swift
//  Custom_Rotate_Button
//
//  Created by Jae kwon Choi on 2022/01/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customButton: RotateButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이 123 이부분은 RotateButton에 구현부이다.
        customButton.selectTypeCallback = { upDownType in
            print(upDownType)
            //만약기능을 추가시킬꺼면
            if upDownType == .up {
                //여기다가 이버튼이 눌렸을떄 기능을 추가시키면된다.
            }
        }
        
        
        
        
        //코드로 올리는법
//        let myButton = RotateButton()
//        self.view.addSubview(myButton)
//
//        //위치설정
//        myButton.translatesAutoresizingMaskIntoConstraints = false
//        myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        myButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        //크기설정 숫자값만넣고싶을때
//        //myButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        myButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
//
//        myButton.backgroundColor = UIColor.orange
//        myButton.setTitle("my custom button", for: .normal)
//        myButton.setImage(UIImage(systemName: "arrowtriangle.down"), for: .normal)
        
        
        
    }


}
