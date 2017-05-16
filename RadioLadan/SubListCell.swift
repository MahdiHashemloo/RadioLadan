//
//  SubListCell.swift
//  RadioLadan
//
//  Created by Apple on 4/30/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit

class SubListCell: UITableViewCell {

    //header
    @IBOutlet weak var headerImage: UIImageView!
    
    //item
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
