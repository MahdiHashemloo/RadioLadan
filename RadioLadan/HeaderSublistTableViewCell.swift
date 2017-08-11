//
//  HeaderSublistTableViewCell.swift
//  RadioLadan
//
//  Created by nazanin hashemloo on 5/11/1396 AP.
//  Copyright © 1396 AP MHDY. All rights reserved.
//

import UIKit

class HeaderSublistTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNamelabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
