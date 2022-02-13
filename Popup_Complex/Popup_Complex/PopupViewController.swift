//
//  PopupViewController.swift
//  Popup_Complex
//
//  Created by Jae kwon Choi on 2022/02/13.
//

import UIKit

class PopupViewController: UIViewController {

    @IBAction func closePopup(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func doneAction(_ sender: Any) {
        print("press done action")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
