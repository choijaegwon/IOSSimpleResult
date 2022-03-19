//
//  ViewController.swift
//  Navigation_Master
//
//  Created by Jae kwon Choi on 2022/01/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNaviTitleImage()
        makeBackButton()
        naviBackgroundDesign()
    }
    
    func naviBackgroundDesign() {
        self.navigationController?.navigationBar.backgroundColor = .red
       // self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    
    func makeBackButton() {
        
        // 작성하면 틴트컬러는 적용되지않는다.
        var backImage = UIImage(systemName: "backward.fill")
        backImage = backImage?.withRenderingMode(.alwaysOriginal)
        
        //두개 다 넣어야지 바뀐다.
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.tintColor = UIColor.orange
        
        self.navigationItem.backButtonTitle = ""
        
    }

    func setNaviTitleImage() {
        //밑에 두개 같은 것
        //self.title = "main view"
        //self.navigationItem.title = "main view"
        
//        //이미지가져오기
//        let logo = UIImageView(image: UIImage(named: "logoSample.jpg"))
//        //왜곡 없애기
//        logo.contentMode = .scaleAspectFit
//        //크기조절
//        logo.widthAnchor.constraint(equalToConstant: 90).isActive = true
//        logo.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        //이미지대입
//        navigationItem.titleView = logo
        
        //버튼으로만들기
        let btn = UIButton()
        //btn.backgroundColor = .orange
        btn.setTitleColor(.blue, for: .normal)
        btn.setTitle("custom button", for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.addTarget(self, action: #selector(testAction), for: .touchUpInside)
        self.navigationItem.titleView = btn
    }

    @objc func testAction() {
        print("test")
    
    }
    
}

