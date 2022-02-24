//
//  MyBubbleTableViewCell.swift
//  KaKao_Test
//
//  Created by Jae kwon Choi on 2022/02/24.
//

import UIKit

class MyBubbleTableViewCell: UITableViewCell {

    @IBOutlet weak var bubbleText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
