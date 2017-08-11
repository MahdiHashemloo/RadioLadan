//
//  CommentCell.swift
//  RadioLadan
//
//  Created by Apple on 6/4/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var commentImage: UIImageView!

    @IBOutlet weak var commentName: UILabel!
    @IBOutlet weak var commentValue: UILabel!
    @IBOutlet weak var commentTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
