//
//  SearchCell.swift
//  RadioLadan
//
//  Created by Apple on 6/5/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemView: UILabel!

    @IBOutlet weak var likedNumLabel: UILabel!
    @IBOutlet weak var commentNumLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
