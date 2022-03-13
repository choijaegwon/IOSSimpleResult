//
//  DraggbleView.swift
//  PanGesturePaa
//
//  Created by Jae kwon Choi on 2021/12/31.
//

import UIKit

class DraggbleView: UIView {
    
    var dragType = DragType.none
    
    init() {
        super.init(frame: CGRect.zero)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
        self.addGestureRecognizer(pan)
    }
    
    //꼭 필요한 설정, 인터페이스 빌더에서 만들어지는 것은 여기를 타게 된다.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dragging(pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .began:
            print("began")
            
        // 움직임 만큼
        case .changed:
            // 움직인 만큼의 값을 알려줌(기준은 부모뷰를 기준)
            let delta = pan.translation(in: self.superview)
            //내 위치는 내 가운데이다
            var myPosition = self.center
            
            //움직임의 값을 제약을 줌
            if dragType == .x {
                myPosition.x += delta.x
            }else if dragType == .y {
                myPosition.y += delta.y
            }else{
                myPosition.x += delta.x
                myPosition.y += delta.y
            }
            
            // 내위치는 움직인 만큼 바뀐 값이다.
            self.center = myPosition
            // 값을 0으로해놓고 움직인 만큼 자꾸 초기화시키는 것이다.
            pan.setTranslation(CGPoint.zero, in: superview)
            
        // 끝났을 때, 너무 멀리가서 취소됐을때
        case .ended, .cancelled:
            print("ended cancelled")
            
            //내가 만든 뷰에 맨끝이 0보다 작아지면
            //왼쪽
            if self.frame.minX < 0 {
                //빨간 상자의 오른쪽 끝값을 origin이라고 부른다.
                self.frame.origin.x = 0
            }
            // 오른쪽
            if let hasSuperView = self.superview {
                // 부모뷰보다 더 오른쪽으로 가면.
                if self.frame.maxX > hasSuperView.frame.maxX {
                    // 오른쪽은 끝을 정할수가 없기 때문에 그냥 부모뷰에서 빨간상자의 크기를 뺸 값이 최대값이다.
                    self.frame.origin.x = hasSuperView.frame.maxX - self.bounds.width
                }
            }
            
        default:
            break
        }
    }
    
    
    
}
