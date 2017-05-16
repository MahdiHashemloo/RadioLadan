//
//  PlayerCell.swift
//  RadioLadan
//
//  Created by Apple on 5/4/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit
protocol playerPr {
    func play_music()
    func pause_music()
    func next_music()
    func previous_music()
    func comment_music()
    func playList_music()
    func change_slider_value(value  : Float)
}
class PlayerCell: UITableViewCell {
     //player cell:
    @IBOutlet weak var artistImage: UIImageView!

    @IBOutlet weak var PlaySlider: UISlider!
   
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var durationTimeLabel: UILabel!
    
    
    
    var playeDelegagte : playerPr?
    
    
    
    
    //otherItems
    @IBOutlet weak var relatedArtistImage: UIImageView!
    
    @IBOutlet weak var relatedArtistName: UILabel!
    
    @IBOutlet weak var relatedItemTitle: UILabel!
    
    @IBOutlet weak var relatedItemDuration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //playerActions:
    @IBAction func comments(_ sender: Any) {
        playeDelegagte?.comment_music()
    }
    
    @IBAction func previousItem(_ sender: Any) {
        playeDelegagte?.previous_music()
        print("prev cell")
    }
    
    @IBAction func playButton(_ sender: Any) {
        playeDelegagte?.play_music()
        print("playin cell")
    }
  
    @IBAction func nextItem(_ sender: Any) {
        playeDelegagte?.next_music()
    }
    
    @IBAction func playList(_ sender: Any) {
        playeDelegagte?.playList_music()
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        
        playeDelegagte?.change_slider_value(value: PlaySlider.value)
    }
    
    
    

}
