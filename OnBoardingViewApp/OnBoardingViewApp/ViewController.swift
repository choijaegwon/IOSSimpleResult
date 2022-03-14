//
//  ViewController.swift
//  OnBoardingViewApp
//
//  Created by Jae kwon Choi on 2022/01/01.
//

import UIKit

class ViewController: UIViewController {
    
    var didShowOnboardingView = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if didShowOnboardingView == false {
            didShowOnboardingView = true
            
            let pageVC = onBoardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
            
            //전체화면으로 띄우기
            pageVC.modalPresentationStyle = .fullScreen
            self.present(pageVC, animated: true, completion: nil)
        }
        
    }


}

