//
//  RotateButton.swift
//  Custom_Rotate_Button
//
//  Created by Jae kwon Choi on 2022/01/17.
//

import UIKit

enum RotateType {
    case up
    case down
}

class RotateButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        //코드로할떄
        //fatalError("init(coder:) has not been implemented")
    }
    
    var isUp = RotateType.down {
        didSet {
            changeDesign()
        }
    }
    
    //var selectCallback: (Bool) -> Void = { _ in }
    var selectTypeCallback: ((RotateType) -> Void)?
    
    
    //설정
    private func configure() {
        self.addTarget(self, action: #selector(selectButton), for: .touchUpInside)
    }
    
    @objc private func selectButton() {
        if isUp == .up {
            isUp = .down
        }else {
            isUp = .up
        }
        
        // 이 123부분이랑 연결되어있다.
        selectTypeCallback?(isUp)
        
    }
    
    private func changeDesign() {
        
        UIView.animate(withDuration: 0.25) {
            if self.isUp == .up {
            //180도 돌림
                self.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.3)
            }else {
            //원래로 돌아감
                self.imageView?.transform = .identity
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
            }
        }
    }

}
