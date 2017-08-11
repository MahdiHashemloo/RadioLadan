//
//  CatItemCell.swift
//  RadioLadan
//
//  Created by Apple on 5/12/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit

class CatItemCell: UITableViewCell {

    @IBOutlet weak var imageViewForCell: UIImageView!
    
    @IBOutlet weak var likeNum: UILabel!
    
    @IBOutlet weak var commentNum: UILabel!
    
    @IBOutlet weak var durationTimeLabel: UILabel!
    
    @IBOutlet weak var itemTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
