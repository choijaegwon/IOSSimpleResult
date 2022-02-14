//
//  ViewController.swift
//  Chat_App
//
//  Created by Jae kwon Choi on 2022/02/14.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var chatTableView: UITableView!{
        // VC에서 사용할수 있도록 연결을 해줘야 한다.
        didSet{
            chatTableView.delegate = self
            chatTableView.dataSource = self
            chatTableView.separatorStyle = .none
        }
    }
    @IBOutlet weak var inputTextViewHeight: NSLayoutConstraint!
    
    var chatDatas = [String]()
    
    @IBOutlet weak var inputTextView: UITextView!{
        didSet{
            inputTextView.delegate = self
        }
    }
    @IBOutlet weak var inputViewBottomMargin: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //외부에서만든 cell가져오기(등록하기)
        chatTableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "MyCell")
        chatTableView.register(UINib(nibName: "YourCell", bundle: nil), forCellReuseIdentifier: "YourCell")
        
        //키보드 관련 옵저버 - 상태를 알려주는 것을 설정 해야 함.
        //키보드 올라올 때
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        //키보드 내려올 떄
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }

    @objc
    func keyboardWillShow(noti: Notification){
        let notiInfo = noti.userInfo!
        let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        //safearea값빼주기
        let height = keyboardFrame.size.height - self.view.safeAreaInsets.bottom
        
        //키보드올라가는 시간
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        //자연스로운 키보드효과
        UIView.animate(withDuration: animationDuration) {
            self.inputViewBottomMargin.constant = height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    func keyboardWillHide(noti: Notification){
        let notiInfo = noti.userInfo!
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animationDuration) {
            self.inputViewBottomMargin.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    @IBAction func sendString(_ sender: Any) {
        // inputTextView.text -> =chatDatas
        chatDatas.append(inputTextView.text)
        inputTextView.text = ""
        
        // 3개 데이터가 있는 array일 경우
        // array.count = 3
        // array row => 개수-1
        let lastIndexPath = IndexPath(row: chatDatas.count - 1, section: 0)
        
        chatTableView.insertRows(at: [lastIndexPath], with: UITableView.RowAnimation.automatic)
        
        //마지막으로 이동
        
        inputTextViewHeight.constant = 40
        chatTableView.scrollToRow(at: lastIndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
            myCell.myTextView.text = chatDatas[indexPath.row]
            myCell.selectionStyle = .none
            return myCell
            
        }else{
            let yourCell = tableView.dequeueReusableCell(withIdentifier: "YourCell", for: indexPath) as! YourCell
            yourCell.yourTextView.text = chatDatas[indexPath.row]
            yourCell.selectionStyle = .none
            return yourCell
            
        }
        
    }
    
    
}

extension ViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.contentSize.height <= 40 {
            inputTextViewHeight.constant = 40
            
        }else if textView.contentSize.height >= 100 {
            inputTextViewHeight.constant = 100
        }else{
            inputTextViewHeight.constant = textView.contentSize.height
        }
    }
}
