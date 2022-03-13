//
//  ViewController.swift
//  PanGesturePaa
//
//  Created by Jae kwon Choi on 2021/12/31.
//

import UIKit

enum DragType {
    //x만 움직이게한다.
    case x
    //y만 움직이게한다.
    case y
    //둘다 움직이게한다.
    case none
}

class ViewController: UIViewController {

    var dragType = DragType.none
    let myView = DraggbleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //이 뷰의 가운데는 내 뷰의 가운대로 하겠다.
        myView.center = self.view.center
        myView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        myView.dragType = .x //시작할 때 x로 시작한ㄷ.
        myView.backgroundColor = .red
        
        //내가 만든 뷰를 올리겠다.
        self.view.addSubview(myView)
        
        
        
    }

    @IBAction func selectPanType(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex{
        case 0:
            //x만 움직이게한다.
            dragType = .x
        case 1:
            //y만 움직이게한다.
            dragType = .y
        case 2:
            dragType = .none
        default:
            break
        }
        
        myView.dragType = self.dragType
    }
    
}

