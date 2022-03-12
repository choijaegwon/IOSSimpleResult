//
//  ProfileCell.swift
//  Setting_Clone_App
//
//  Created by Jae kwon Choi on 2021/11/13.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var bottomDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let profileHeight: CGFloat = 60
        profileImageView.layer.cornerRadius = profileHeight / 2
        
        topTitle.textColor = .blue
        topTitle.font = UIFont.systemFont(ofSize: 20)
        
        bottomDescription.textColor = .darkGray
        bottomDescription.font = UIFont.systemFont(ofSize: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
