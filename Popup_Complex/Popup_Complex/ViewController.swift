//
//  ViewController.swift
//  Popup_Complex
//
//  Created by Jae kwon Choi on 2022/02/13.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func showPopup(_ sender: Any) {
    //popupVC나오게하기
        
        let storyBoard = UIStoryboard.init(name: "PopupViewController", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "popupVC")
        
        //투명도에 맞춘다.
        popupVC.modalPresentationStyle = .overCurrentContext
        
        self.present(popupVC, animated: false, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

