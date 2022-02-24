//
//  YourBubbleTableViewCell.swift
//  KaKao_Test
//
//  Created by Jae kwon Choi on 2022/02/25.
//

import UIKit

class YourBubbleTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var bubbleText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImage.layer.cornerRadius = 30 / 2
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
