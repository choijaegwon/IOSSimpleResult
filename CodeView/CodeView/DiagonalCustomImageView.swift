//
//  DiagonalCustomImageView.swift
//  CodeView
//
//  Created by Jae kwon Choi on 2022/02/16.
//

import UIKit

@IBDesignable
class DiagonalCustomImageView: UIImageView {

    // 대각선으로 잘린 사각형을 그린다.
    // bezierPath
    
    // path -> layer
    
    // layer -> mask
    
    // 내가만든 커스텀 코드 -> storyboard 편집화면에서 바로 확인
    
    @IBInspectable var innerHeight: CGFloat = 0
    
    func makePath() -> UIBezierPath {
        let path = UIBezierPath()
        //path.move(to: CGPoint.init(x: 0, y: 0))
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint.init(x: self.bounds.width, y: 0))
        path.addLine(to: CGPoint.init(x: self.bounds.width, y: self.bounds.height))
        path.addLine(to: CGPoint.init(x: 0, y: self.bounds.height - innerHeight ))
        path.close()
        
        return path
    }
    
    func pathToLayer() -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = makePath().cgPath
        
        return shapeLayer
    }
    
    func makeMask() {
        self.layer.mask = pathToLayer()
    }
    
    //그려질때
    override func layoutSubviews() {
        makeMask()
    }
    
}
