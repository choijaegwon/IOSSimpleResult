//
//  ViewController.swift
//  KaKao_Test
//
//  Created by Jae kwon Choi on 2022/02/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var inputViewBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var TextViewHeight: NSLayoutConstraint!
    
    var chatData: NSMutableArray! = ["hi", "oh hi"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //셀등록
        chatTableView.register(UINib(nibName: "MyBubbleTableViewCell", bundle: nil), forCellReuseIdentifier: "myBubbleCell")
        
        chatTableView.register(UINib(nibName: "YourBubbleTableViewCell", bundle: nil), forCellReuseIdentifier: "yourCell")
        
        
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.delegate = self
        chatTableView.dataSource = self
        inputTextView.delegate = self
        
        // 키보드의 노티피케이션(상태를알려줌)등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti: )), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    //텍스트글자쓸떄마다 높이지정
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.contentSize.height <= 83 {
            TextViewHeight.constant = textView.contentSize.height
            textView.setContentOffset(CGPoint.zero, animated: true)
        }
        
        self.view.layoutIfNeeded()
        
    }
    

    @objc
    func keyboardWillShow(noti: NSNotification) {
        // 키보드의 높이를 가져오는 작업
        let notiInfo = noti.userInfo! as NSDictionary
        let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let height = keyboardFrame.size.height - self.view.safeAreaInsets.bottom
        
        inputViewBottomMargin.constant = height
        
        // 애니메이션 추가
        // 키보드의 움직이는 시간을 가져와야 함
        // 그 시간만큼 텍스트 인폿뷰를 애니메이션 형태로 올라오게 만들면 자연스럽게 보일 것이다.
        let animationDuration = notiInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    func keyboardWillHide(noti: NSNotification) {
        
        let notiInfo = noti.userInfo! as NSDictionary
        
        inputViewBottomMargin.constant = 0
        
        let animationDuration = notiInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatData.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let defaultCell:UITableViewCell
        
        if indexPath.row % 2 == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myBubbleCell", for: indexPath) as! MyBubbleTableViewCell
            cell.bubbleText.text = (chatData[indexPath.row] as! String)
            
            defaultCell = cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "yourCell", for: indexPath) as! YourBubbleTableViewCell
            cell.bubbleText.text = (chatData[indexPath.row] as! String)
            
            defaultCell = cell
        }
        

        defaultCell.selectionStyle = .none
        return defaultCell
        
    }

    @IBAction func textInputDone(_ sender: Any) {
        
        if inputTextView.hasText {
            chatData.add(inputTextView.text!)
            chatTableView.reloadData()
            
            inputTextView.text = ""
            
            let lastIndexPath = NSIndexPath(row: chatData.count - 1, section: 0) as IndexPath
            
            self.view.layoutIfNeeded()
            
            
            chatTableView.scrollToRow(at: lastIndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
            
            self.textViewDidChange(inputTextView)
        }
    }
    
}

