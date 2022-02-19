//
//  ViewController.swift
//  ExpandCellAtLabel
//
//  Created by Jae kwon Choi on 2022/02/18.
//

import UIKit

class ExpandCell: UITableViewCell {
   
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // 필요한 텍스트가 포함.
    // expand 상태
    
    // Model
    struct ExpandDataModel {
        var description: String
        var isExpand: Bool
    }
    
    var dataModels = [ExpandDataModel].init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textArray = ["short Text", "long long long long long long long long long long long text",
                         "short Text", "long long long long long long long long long long long text",
                         "short Text", "long long long long long long long long long long long text"]
        
        for (_, value) in textArray.enumerated() {
            dataModels.append(ExpandDataModel.init(description: value, isExpand: false))
        }
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expandCell_ID", for: indexPath) as! ExpandCell
        
        cell.descriptionLabel.text = dataModels[indexPath.row].description
        
        if dataModels[indexPath.row].isExpand == true {
            cell.descriptionLabel.numberOfLines = 0
        }else {
            cell.descriptionLabel.numberOfLines = 1
        }
        
        cell.selectionStyle = .none
        
        return cell
        
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataModels[indexPath.row].isExpand = !dataModels[indexPath.row].isExpand
        
        //방법1. tavleView.reloadData()
        //방법2. heightForRowAt()에서 정확한 높이를 지정 확실히 해결됨
        //방법3.
        //tableView.estimatedSectionFooterHeight = 0
        //tableView.estimatedSectionHeaderHeight = 0
        //방법4. 애니메이션 효과 없애는 방법 확실히 해결
//        UIView.setAnimationsEnabled(false)
//        tableView.reloadRows(at: [indexPath], with: .none)
//        UIView.setAnimationsEnabled(true)
                
        UIView.setAnimationsEnabled(false)
        //화면재구성 갱신함
        tableView.reloadRows(at: [indexPath], with: .none)
        UIView.setAnimationsEnabled(true)
    }

}
