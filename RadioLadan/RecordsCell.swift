//
//  RecordsCell.swift
//  RadioLadan
//
//  Created by nazanin hashemloo on 5/7/1396 AP.
//  Copyright © 1396 AP MHDY. All rights reserved.
//

import UIKit

protocol uploadActionPr {
    func upLoadActionWithIndex(index:Int)
}

class RecordsCell: UITableViewCell {
    var cellUploadDelegate : uploadActionPr?
     var cellIndex = 0
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func UploadAction(_ sender: Any) {
   
        
        self.cellUploadDelegate?.upLoadActionWithIndex(index: cellIndex)
        
    }

}
