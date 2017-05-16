//
//  HeaderSelecedCell.swift
//  RadioLadan
//
//  Created by Apple on 5/1/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit

class HeaderSelecedCell: UITableViewCell {
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
