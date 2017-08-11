//
//  SublistTableViewCell.swift
//  RadioLadan
//
//  Created by nazanin hashemloo on 5/11/1396 AP.
//  Copyright © 1396 AP MHDY. All rights reserved.
//

import UIKit

class SublistTableViewCell: UITableViewCell {
    @IBOutlet weak var Icon: UIButton!
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
