//
//  PlayListCell.swift
//  RadioLadan
//
//  Created by Apple on 5/6/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit

class PlayListCell: UITableViewCell {
    @IBOutlet weak var imageViewPlayList: UIImageView!
    @IBOutlet weak var playListName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
