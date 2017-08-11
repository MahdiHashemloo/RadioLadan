//
//  JukeBoxClass.swift
//  RadioLadan
//
//  Created by Apple on 6/10/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit
import AVFoundation
import Jukebox

var playItem2 = GetMusicFromVitrinResponse()
var jukebox2 : Jukebox!
var  jukeBoxState2 : Jukebox.State?
var jukeItemArr2 = [JukeboxItem]()

class JukeBoxClass: NSObject,AVAudioPlayerDelegate,JukeboxDelegate {
    
    
     override init() {
        super.init()
    
    
    jukebox2 = Jukebox(delegate: self, items: jukeItemArr)!
    
    
    
    }
    
    
    
    //MARK: -jukebox delegate
    
    
    func jukeboxDidLoadItem(_ jukebox: Jukebox, item: JukeboxItem) {
        
        
        if let file = playItem.image {
              //       let processor = BlurImageProcessor(blurRadius: 5)
          //  playPageBackGrond.kf.setImage(with: URL(string: file), placeholder: nil, options: [.processor(processor)], progressBlock: nil, completionHandler: nil  )
            
        }
        
        print("Jukebox did load: \(item.URL.lastPathComponent)")
        if let d = jukebox.currentItem?.meta.duration {
            
            //sliderMaxValue = d
            print("sliderMaxValue = \(d)")
//            if scrollOffset <= 0.0 {
//                playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
//            }
            
        }
        //playeTableView.reloadData()
    }
    
    func jukeboxPlaybackProgressDidChange(_ jukebox: Jukebox) {
        
        if let currentTime = jukebox.currentItem?.currentTime, let duration = jukebox.currentItem?.meta.duration {
            let value = Float(currentTime )
            print("sliderValue = \( Double(value))")
            
            print("time lebels:")
            print(value)
            
            let mySecs = Int(value) % 60
            let myMins = Int(value / 60)
            
            print("currentTimeOfMusic =" + "\(myMins):\(mySecs)")
            
            let mySecs2 = Int((jukebox.currentItem?.meta.duration)!) % 60
            let myMins2 = Int((jukebox.currentItem?.meta.duration)! / 60)
          //  durationTimeOfMusic  = "\(myMins2):\(mySecs2)"
             print("durationTimeOfMusic =" + "\(myMins2):\(mySecs2)")
            
            print(duration)
//            if scrollOffset <= 0.0 {
//                
//                playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
//            }
            
                  } else {
            //resetUI()
        }
    }
    
    func jukeboxStateDidChange(_ jukebox: Jukebox) {
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            // self.indicator.alpha = jukebox.state == .loading ? 1 : 0
            jukeBoxState = jukebox.state
            
           // self.playeTableView.reloadData()
 
        })
        
        if jukebox.state == .ready {
            
        //    playButtonImage = #imageLiteral(resourceName: "play")
        } else if jukebox.state == .loading  {
      
         //   playButtonImage = #imageLiteral(resourceName: "pause")
        } else {
            // volumeSlider.value = jukebox.volume
            let imageName: String
            switch jukebox.state {
            case .playing, .loading:
                imageName = "pauseBtn"
              //  playButtonImage = #imageLiteral(resourceName: "pause")
            case .paused, .failed, .ready:
                imageName = "playBtn"
               // playButtonImage = #imageLiteral(resourceName: "play")
            }
            //  playPauseButton.setImage(UIImage(named: imageName), for: UIControlState())
        }
        
        
//        if scrollOffset <= 0.0 {
//            
//            playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
//        }
        
        
        // playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
        print("Jukebox state changed to \(jukebox.state)")
//        let processor = BlurImageProcessor(blurRadius: 2)
//        playPageBackGrond.kf.setImage(with: URL(string: imageURLs[jukebox.playIndex]), placeholder: nil, options: [.processor(processor)], progressBlock: nil, completionHandler: nil  )
    }
    
    func jukeboxDidUpdateMetadata(_ jukebox: Jukebox, forItem: JukeboxItem) {
        print("Item updated:\n\(forItem)")
        
//        if scrollOffset <= 0.0 {
//            
//            playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
//        }
        //  playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
    }
    
    
//    override func remoteControlReceived(with event: UIEvent?) {
//        if event?.type == .remoteControl {
//            switch event!.subtype {
//            case .remoteControlPlay :
//                jukebox.play()
//            case .remoteControlPause :
//                jukebox.pause()
//            case .remoteControlNextTrack :
//                jukebox.playNext()
//            case .remoteControlPreviousTrack:
//                jukebox.playPrevious()
//            case .remoteControlTogglePlayPause:
//                if jukebox.state == .playing {
//                    jukebox.pause()
//                } else {
//                    jukebox.play()
//                }
//            default:
//                break
//            }
//        }
//    }
    
    
    
    
    

}
