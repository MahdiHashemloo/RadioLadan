//
//  HeaderTableViewCell.swift
//  Test
//
//  Created by ios-user on 1/19/17.
//  Copyright © 2017 ios-user. All rights reserved.
//

import UIKit

protocol HeaderTableViewCellDelegate {
    func didSelectUserHeaderTableViewCell(Selected: Bool, UserHeader: HeaderTableViewCell)
}


class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var loadMoreIcon: UIImageView!
    
    @IBOutlet weak var loadMoreLabel: UILabel!
    
    @IBOutlet weak var sectionHeaderLabel: UILabel!
    
    
    
    var cityName : String?
    var header_Id = ""
    var sectionNumber : Int?
    var cityId : Int?
     var delegate : HeaderTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
       // self.transform = CGAffineTransform(scaleX: -1 , y: 1)
        if let l = loadMoreIcon {
        
         l.transform = CGAffineTransform(scaleX: -1 , y: 1)
            loadMoreIcon.transform = CGAffineTransform(scaleX: -1 , y: 1)
            loadMoreLabel.transform = CGAffineTransform(scaleX: -1, y: 1)
            sectionHeaderLabel.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func loadMoreButton(_ sender: Any) {
        
        delegate?.didSelectUserHeaderTableViewCell(Selected: true, UserHeader: self)
    }
}
