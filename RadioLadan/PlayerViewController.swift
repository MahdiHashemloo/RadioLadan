//
//  PlayerViewController.swift
//  RadioLadan
//
//  Created by Apple on 5/4/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit
import AVFoundation
import Jukebox
import Kingfisher

var playItem = GetMusicFromVitrinResponse()

class PlayerViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,playerPr, AVAudioPlayerDelegate,JukeboxDelegate{

    
    
    
    var sliderValue = 0.0
    var sliderMinValue = 0.0
    var sliderMaxValue = 2.7
    var currentTimeOfMusic = ""
    var durationTimeOfMusic = ""
    
    var playButtonImage = #imageLiteral(resourceName: "play")
    var jukeBoxState : Jukebox.State?
    var jukebox : Jukebox!
    var audioPlayer = AVAudioPlayer()
    let path = Bundle.main.path(forResource: "", ofType: "")
    
    @IBOutlet weak var playPageBackGrond: UIImageView!
    @IBOutlet weak var playeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        // 2
        let nav = self.navigationController?.navigationBar
        nav?.isTranslucent = true
        nav?.barStyle = UIBarStyle.blackTranslucent
        
              // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let file = playItem.image {
            //  playPageBackGrond.kf.setImage(with: URL(string: file))
            let processor = BlurImageProcessor(blurRadius: 5)
            playPageBackGrond.kf.setImage(with: URL(string: file), placeholder: nil, options: [.processor(processor)], progressBlock: nil, completionHandler: nil  )
            
        }
        var jukeItemArr = [JukeboxItem]()
        do {
            if let related = playItem.related_items {
                for i in related {
                    
                   print("-----\(i.file)")
                  jukeItemArr.append( JukeboxItem(URL: URL(string: i.file!)!))
                }
            
            }
             if let related = playItem.related_items {
            jukeItemArr.insert(JukeboxItem(URL: URL(string: playItem.file!)!), at: 0)
            }
            if let tb = playItem.related_items {
            
                self.playeTableView.delegate = self
                self.playeTableView.dataSource = self
            }else{
            alert2(msg: "error!")
            
            }
            
            UIApplication.shared.beginReceivingRemoteControlEvents()
//            jukebox = Jukebox(delegate: self, items: [
//                JukeboxItem(URL: URL(string: "http://ihamsane.ir/ladan/admin/uploads/YK168499PH5296471.mp3")!),
//                JukeboxItem(URL: URL(string: "http://ihamsane.ir/ladan/admin/uploads/YK168499PH5296471.mp3")!),
//                JukeboxItem(URL: URL(string: "http://ihamsane.ir/ladan/admin/uploads/YK168499PH5296471.mp3" )!)
//                ])!
            jukebox = Jukebox(delegate: self, items: jukeItemArr)!
            
            //            audioPlayer = try AVAudioPlayer(contentsOf:URL.init(fileURLWithPath: Bundle.main.path(forResource: "sound", ofType: "mp3")!))
            
            // audioPlayer = try AVAudioPlayer(contentsOf:URL.init(fileURLWithPath: Bundle.main.path(forResource: "sound", ofType: "mp3")!))
            
            
            //audioPlayer.prepareToPlay()
            
        }
        catch{}
        if let d = jukebox.currentItem?.meta.duration {
            // slider.maximumValue = Float(d)
            sliderValue = d
            if playItem.related_items?.count != 0 {
                playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
            }
            
        }
        
        // slider.maximumValue = Float(audioPlayer.duration )
        //jukebox.currentItem?.meta.duration
        var timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        
        
      
        if let tb = playItem.related_items {
            playeTableView.reloadData()
        }

    }

    func updateSlider() {
        //slider.value = Float(audioPlayer.currentTime    )
        if let t = (jukebox.currentItem?.currentTime) {
            
//            slider.value = Float( t )
//            NSLog("hi")
            
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tableViewMethods:
    func numberOfSections(in tableView: UITableView) -> Int {
        print(playItem.related_items?.count)
        return ((playItem.related_items?.count)! + 2 )
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
            if let file = playItem.image {
            
             cell.artistImage.kf.setImage(with: URL(string: file))
            }
           
            cell.PlaySlider.value = Float(sliderValue)
            cell.PlaySlider.maximumValue = Float(sliderMaxValue)
            cell.PlaySlider.minimumValue = 0.0
            //====================player buttons:========
            cell.PlaySlider.setThumbImage(#imageLiteral(resourceName: "sliderIcon"), for: .normal)
           // PlaySlider
           // self.jukeBoxState = .loading
            //in thr cell for row:
            if jukeBoxState == Jukebox.State.loading {
            cell.playButton.alpha = 0
                cell.playButton.setImage(playButtonImage, for: .normal)
                print("loading")
            }else if(jukeBoxState == Jukebox.State.playing){
                cell.playButton.alpha = 1
                cell.playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
                print("playing")
                PlayingMode = true
            
            }else if (jukeBoxState == Jukebox.State.paused){
                cell.playButton.alpha = 1
                cell.playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
                print("paused")
                               
                
            
            }
            cell.currentTimeLabel.text = currentTimeOfMusic
            cell.durationTimeLabel.text = durationTimeOfMusic
            
                      // cell.play_Pause_Button.setImage(playButtonImage, for: .normal)
     //============================================
        cell.playeDelegagte  = self
        return cell
        }else if (indexPath.section == 1) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! PlayerCell
            
            //  cell.playeDelegagte  = self
            return cell
        }
else {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "relativeItems", for: indexPath) as! PlayerCell
        
          //  cell.playeDelegagte  = self
            
            print((playItem.related_items?.count)! + 2)
            print(indexPath.section)
            cell.relatedArtistName.text = playItem.related_items?[(indexPath.section) - 2].title
            cell.relatedItemTitle.text = playItem.related_items?[(indexPath.section) - 2].authors
            if let file = (playItem.related_items?[(indexPath.section) - 2].image) {
            
            cell.relatedArtistImage.kf.setImage(with: URL(string: (file)))
            
            }
            
            return cell
        }
    }
    //relativeItems
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 {
        return 500
        } else if indexPath.section == 1 {
        return 50
        } else {
        
        return 100
        }
    }
    
    
    //mark: playeDelegates methods:
    
    func play_music() {
        print("play")
        if jukeBoxState == .playing {
        jukebox.pause()
        
        }else{
        jukebox.play()
        }
        print(jukebox.playIndex)
        playeTableView.reloadData()
        
    }
    
    func playList_music() {
        
    }
    
    func previous_music() {
        jukebox.playPrevious()
    }
    func next_music() {
        jukebox.playNext()
        print(jukebox.playIndex)
        
    }
    
    func comment_music() {
        
    }
    
    func change_slider_value(value: Float) {
        jukebox.seek(toSecond: Int(value))
        
    }
    func pause_music() {
        
    }
    
    
    
    
    // MARK:- JukeboxDelegate -
    
    func jukeboxDidLoadItem(_ jukebox: Jukebox, item: JukeboxItem) {
    
        /*let processor = RoundCornerImageProcessor(cornerRadius: 20)
         imageView.kf.setImage(with: url, placeholder: nil, options: [.processor(processor)])*/
        
        if let file = playItem.image {
      //  playPageBackGrond.kf.setImage(with: URL(string: file))
            let processor = BlurImageProcessor(blurRadius: 5)
            playPageBackGrond.kf.setImage(with: URL(string: file), placeholder: nil, options: [.processor(processor)], progressBlock: nil, completionHandler: nil  )
           
        }
        
        print("Jukebox did load: \(item.URL.lastPathComponent)")
        if let d = jukebox.currentItem?.meta.duration {
           // slider.maximumValue = Float(d)
            sliderMaxValue = d
            playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
        }
        playeTableView.reloadData()
    }
    
    func jukeboxPlaybackProgressDidChange(_ jukebox: Jukebox) {
        
        if let currentTime = jukebox.currentItem?.currentTime, let duration = jukebox.currentItem?.meta.duration {
            let value = Float(currentTime )
           // slider.value = value
            sliderValue = Double(value)
            print("time lebels:")
            print(value)
           
            let mySecs = Int(value) % 60
            let myMins = Int(value / 60)
            currentTimeOfMusic = "\(myMins):\(mySecs)"
          //  var str = currentTimeOfMusic/60
            let mySecs2 = Int((jukebox.currentItem?.meta.duration)!) % 60
            let myMins2 = Int((jukebox.currentItem?.meta.duration)! / 60)
            durationTimeOfMusic  = "\(myMins2):\(mySecs2)"
            print(duration)
                    playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
          //  print(value)
            // populateLabelWithTime(currentTimeLabel, time: currentTime)
            //  populateLabelWithTime(durationLabel, time: duration)
        } else {
            //resetUI()
        }
    }
    
    func jukeboxStateDidChange(_ jukebox: Jukebox) {
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            // self.indicator.alpha = jukebox.state == .loading ? 1 : 0
            self.jukeBoxState = jukebox.state
            
            self.playeTableView.reloadData()
            //in thr cell for row:
//            self.playPauseButton.alpha = jukebox.state == .loading ? 0 : 1
//            
//            self.playPauseButton.isEnabled = jukebox.state == .loading ? false : true
        })
        
        if jukebox.state == .ready {
          //  playPauseButton.setImage(UIImage(named: "playBtn"), for: UIControlState())
            playButtonImage = #imageLiteral(resourceName: "play")
        } else if jukebox.state == .loading  {
         //   playPauseButton.setImage(UIImage(named: "pauseBtn"), for: UIControlState())
            playButtonImage = #imageLiteral(resourceName: "pause")
        } else {
            // volumeSlider.value = jukebox.volume
            let imageName: String
            switch jukebox.state {
            case .playing, .loading:
                imageName = "pauseBtn"
                playButtonImage = #imageLiteral(resourceName: "pause")
            case .paused, .failed, .ready:
                imageName = "playBtn"
                playButtonImage = #imageLiteral(resourceName: "play")
            }
          //  playPauseButton.setImage(UIImage(named: imageName), for: UIControlState())
        }
        playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
        print("Jukebox state changed to \(jukebox.state)")
    }
    
    func jukeboxDidUpdateMetadata(_ jukebox: Jukebox, forItem: JukeboxItem) {
        print("Item updated:\n\(forItem)")
        playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
    }
    
    
    override func remoteControlReceived(with event: UIEvent?) {
        if event?.type == .remoteControl {
            switch event!.subtype {
            case .remoteControlPlay :
                jukebox.play()
            case .remoteControlPause :
                jukebox.pause()
            case .remoteControlNextTrack :
                jukebox.playNext()
            case .remoteControlPreviousTrack:
                jukebox.playPrevious()
            case .remoteControlTogglePlayPause:
                if jukebox.state == .playing {
                    jukebox.pause()
                } else {
                    jukebox.play()
                }
            default:
                break
            }
        }
    }
    
    //navigation bar buttons:
    
    @IBAction func backToHome(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func likeButton(_ sender: Any) {
    }

    @IBAction func rightMenu(_ sender: Any) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
