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
var cachedPlayItem = GetMusicFromVitrinResponse()
var playItem = GetMusicFromVitrinResponse()
var jukebox : Jukebox!
var  jukeBoxState : Jukebox.State?
var jukeItemArr = [JukeboxItem]()
var playObjCached = PlayItemObject()
//
var item_ids = [String]()
var itemTitles = [String]()
class PlayerViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,playerPr, AVAudioPlayerDelegate,JukeboxDelegate,pannelProtocol,AddFavoritePr{

    var playObj = PlayItemObject()
    
    var blurView = false
    @IBOutlet weak var backBlurButton: UIButton!
    @IBOutlet weak var blurMenuView: UIView!
    @IBOutlet weak var subListTableView: UITableView!
    
    
    
    
    var scrollOffset = 0.0
    
    
    var sliderValue = 0.0
    var sliderMinValue = 0.0
    var sliderMaxValue = 2.7
    var currentTimeOfMusic = ""
    var durationTimeOfMusic = ""
    
    var playButtonImage = #imageLiteral(resourceName: "play_large")
    
    
    
    var audioPlayer = AVAudioPlayer()
    let path = Bundle.main.path(forResource: "", ofType: "")
    
    
    var imageUrlStringArray = [String]()
    var titleStringArray = [String]()
    
    @IBOutlet weak var playPageBackGrond: UIImageView!
    @IBOutlet weak var playeTableView: UITableView!
    
    let homeObj = HomeViewController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        
        blurViewImplementation()
        homeObj.panelDelegate = self
        netObject.addFavoriteDelegate =  self
     //   let jObj = JukeBoxClass()
        // 2
        
              // Do any additional setup after loading the view.
    }
    var fromSongSelection = false
    override func viewDidAppear(_ animated: Bool) {
        
        if let tb = subListTableView {
            subListTableView.dataSource = self
            subListTableView.delegate = self
        
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = blurMenuView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurMenuView.addSubview(blurEffectView)
            
            blurEffectView.addSubview(subListTableView)
            blurEffectView.addSubview(backBlurButton)
            blurMenuView.alpha = 0

        }
    
        
       
        if fromSongSelection {
            fromSongSelection = false
        
            if jukeBoxState == .playing {
            
                                  let processor = BlurImageProcessor(blurRadius: 5)
                    playPageBackGrond.kf.setImage(with: URL(string: playObj.image), placeholder: nil, options: [.processor(processor)], progressBlock: nil, completionHandler: nil  )
                    
                                 //}
 
            } else {
                if let file = playItem.image {
                    //  playPageBackGrond.kf.setImage(with: URL(string: file))
                    let processor = BlurImageProcessor(blurRadius: 5)
                    playPageBackGrond.kf.setImage(with: URL(string: file), placeholder: nil, options: [.processor(processor)], progressBlock: nil, completionHandler: nil  )
                  
                }
                
//                currentTimeOfMusic = "00:00"
//                let mySecs2 = Int((jukebox.currentItem?.meta.duration)!) % 60
//                let myMins2 = Int((jukebox.currentItem?.meta.duration)! / 60)
//                durationTimeOfMusic  = "\(myMins2):\(mySecs2)"

            
            }
            

                if jukeBoxState == .playing {
                   // jukebox.stop()
                    addRelatedItems()
                } else {
                    addRelatedItems()
                    
                }
            
         //   }
            
           
        
            
       
        
            var timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        
        
      
        if let tb = playItem.related_items {
            _ = tb
            playeTableView.reloadData()
        }

        }else{
            if jukeBoxState == .playing {
                // jukebox.stop()
                addRelatedItems()
                jukebox.play()
            } else {
                addRelatedItems()
                jukebox.play()
            }
        
        }
    }

    func updateSlider() {
        if let t = (jukebox.currentItem?.currentTime) {
            _ = t
          currentItem.image = imageURLs[jukebox.playIndex]
            currentMusicLabel.text = jukebox.currentItem?.localTitle
            let processor = BlurImageProcessor(blurRadius: 5)
            playPageBackGrond.kf.setImage(with: URL(string: currentItem.image!), placeholder: nil, options: [.processor(processor)], progressBlock: nil, completionHandler: nil  )
            
            
            if let d = jukebox.currentItem?.meta.duration {
                // slider.maximumValue = Float(d)
                sliderMaxValue = d
                if  (playeTableView.contentSize.height < playeTableView.frame.size.height) {
                    
                }
//                if scrollOffset <= 0.0 {
//                    playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
//                }
                if shouldReload() {
                    playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)

                
                }
                
            }
            playeTableView.reloadData()
            
            
            if let currentTime = jukebox.currentItem?.currentTime, let duration = jukebox.currentItem?.meta.duration {
                
                currentItem.image = imageURLs[jukebox.playIndex]
                currentItem.title = itemTitles[jukebox.playIndex]
                let value = Float(currentTime )
                // slider.value = value
                sliderValue = Double(value)
                               let mySecs = Int(value) % 60
                let myMins = Int(value / 60)
                currentTimeOfMusic = "\(myMins):\(mySecs)"
                //  var str = currentTimeOfMusic/60
                let mySecs2 = Int((jukebox.currentItem?.meta.duration)!) % 60
                let myMins2 = Int((jukebox.currentItem?.meta.duration)! / 60)
                durationTimeOfMusic  = "\(myMins2):\(mySecs2)"
                
                if shouldReload() {
                    playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
                    
                    
                }
                           }
            
            
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tableViewMethods:
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == subListTableView {
            return (subListData.items?.count)!
        }else{
      return 1
        }

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == subListTableView {
            return 1
        }else{
        if let c = playItem.related_items?.count {
            return 1 + c
        }else{
            return 1
        }
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == playeTableView {
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
            if let file = playItem.image {
            
            
             cell.artistImage.kf.setImage(with: URL(string: imageURLs[jukebox.playIndex] ?? file))
            }
           
            cell.PlaySlider.value = Float(sliderValue)
            cell.PlaySlider.maximumValue = Float(sliderMaxValue)
            cell.PlaySlider.minimumValue = 0.0
            //====================player buttons:========
            cell.PlaySlider.setThumbImage(#imageLiteral(resourceName: "circular-shape-silhouette"), for: .normal)
           // PlaySlider
           // self.jukeBoxState = .loading
            //in thr cell for row:
            if jukeBoxState == Jukebox.State.loading {
            cell.playButton.alpha = 0
                cell.playButton.setImage(playButtonImage, for: .normal)
            }else if(jukeBoxState == Jukebox.State.playing){
                cell.playButton.alpha = 1
                cell.playButton.setImage(#imageLiteral(resourceName: "pause-big-bold"), for: .normal)
                playingOrPause = true
                PlayingMode = true
            
            }else if (jukeBoxState == Jukebox.State.paused){
                cell.playButton.alpha = 1
                cell.playButton.setImage(#imageLiteral(resourceName: "play-big-bold"), for: .normal)
                 playingOrPause = true
                
                
            
            }
            cell.currentTimeLabel.text = currentTimeOfMusic
            cell.durationTimeLabel.text = durationTimeOfMusic
            
                      // cell.play_Pause_Button.setImage(playButtonImage, for: .normal)
     //============================================
        cell.playeDelegagte  = self
        return cell
        }

           else {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "relativeItems", for: indexPath) as! PlayerCell
        
            
            cell.relatedArtistName.text = playItem.related_items?[(indexPath.row) - 1].title
            cell.relatedItemTitle.text = playItem.related_items?[(indexPath.row) - 1].authors
            if let file = (playItem.related_items?[(indexPath.row) - 1].image) {
            
            cell.relatedArtistImage.kf.setImage(with: URL(string: (file)))
            }
            
            return cell
        }
            
        }else{
            
            
            if indexPath.section == 0 {
                //header
                let cell = tableView.dequeueReusableCell(withIdentifier: "subListHeaderCell", for: indexPath) as! SubListCell
                // cell.vitrinContent = vitrinData
                if islogedIn {
                    // cell.headerImage.kf.setImage(with: profileObj.)
                    cell.headerNameLabel.text = " " + profileObj.fname! + " " + profileObj.lname!
                    cell.headerEMailLabel.text = profileObj.email!
                }else{
                    cell.headerNameLabel.text = "میهمان"
                    cell.headerEMailLabel.text = ""
                    
                }
                return cell
            }else{
                //item
                let cell = tableView.dequeueReusableCell(withIdentifier: "subListItemCell", for: indexPath) as! SubListCell
                if let img = (subListData.items?[indexPath.section].image) {
                    cell.itemImage.kf.setImage(with:URL(string:img), placeholder: nil, options:[.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
                    cell.itemLabel.text = subListData.items?[indexPath.section].title
                    
                    //  cell.itemLabel.highlightedTextColor = UIColor.blue
                    
                }
                
                // cell.vitrinContent = vitrinData
                return cell
            }
            
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == subListTableView {
            //{"type":"content_list","list_type":"cat,author,vitrin,playlist,genre","id":"1","user_id":"1","key_word":"","page":"0","num":"10"}
            
            //har cell ke select mishe id dare ke ba in API datash ro migirim
            if indexPath.section == 0 {
                //goto profile
                if islogedIn {
                    //goto profile page
                    let p = storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
                    
                    navigationController?.pushViewController(p, animated: true)
                    
                }else{
                    //goto log in  page
                    let login = storyboard?.instantiateViewController(withIdentifier: "PhoneNumberController") as! PhoneNumberController
                    
                    navigationController?.pushViewController(login, animated: true)
                    
                    
                }
                
            }else if indexPath.section == 1 {
                //go to play list page
                let playListObj = storyboard?.instantiateViewController(withIdentifier: "PlayListViewController") as! PlayListViewController
                //  subListData.items?[indexPath.section].id
                playListObj.fromMenu = true
                
                self.navigationController?.pushViewController(playListObj, animated: true)
                
            }else{
                
                let detail = storyboard?.instantiateViewController(withIdentifier: "CatListItemController") as! CatListItemController
                navigationController?.pushViewController(detail, animated: true)
            }
            //che safe e?
            
            
        }
        else{
        jukebox.play(atIndex: indexPath.row)
        }
    }
    //relativeItems
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        if tableView == subListTableView {
            if indexPath.section == 0 {
                
                return self.view.frame.size.height/3
            }else{
                return 50
            }
            
        }else{
            //playerTableView:
        if indexPath.row == 0 {
        return 500
        } else if indexPath.row == 1 {
        return 100
        } else {
        
        return 100
        }
        }
    }
    
    
    //mark: playeDelegates methods:
    
    func play_music() {
        if jukeBoxState == .playing {
        jukebox.pause()
        
        }else{
        jukebox.play()
        }
        playingOrPause = true
        playeTableView.reloadData()
        
    }
    
    func playList_music() {
        //add to playlist
        let itemId = item_ids[jukebox.playIndex]
        let playListObj = storyboard?.instantiateViewController(withIdentifier: "PlayListViewController") as! PlayListViewController
        playListObj.addToPlayList = true
        playListObj.itemIdForAddToPlayList = itemId
        present(playListObj, animated: true, completion: nil)
       // navigationController?.pushViewController(playListObj, animated: true)
        
      //  let addToPlayListObj
        
        //add to playlist:12{"type":"add_to_playlist","playlist_id":"2","content_id":"1","place":"2","user_id":"1"}
        
    }
    
    func previous_music() {
        jukebox.playPrevious()
    }
    func next_music() {
        jukebox.playNext()
       
        
    }
    
    func comment_music() {
    
        let commentPage = storyboard?.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        commentPage.itemId = item_ids[jukebox.playIndex]
        present(commentPage, animated: true, completion: nil)
        
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
            currentItem.image = imageURLs[jukebox.playIndex]
            currentMusicLabel.text = jukebox.currentItem?.localTitle
           
        }
        
        if let d = jukebox.currentItem?.meta.duration {
           // slider.maximumValue = Float(d)
            sliderMaxValue = d
            if  (playeTableView.contentSize.height < playeTableView.frame.size.height) {
            
            }

            
            if shouldReload() {
                playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
                
                
            }
          
        }
        
     
        playeTableView.reloadData()
    }
    
    func jukeboxPlaybackProgressDidChange(_ jukebox: Jukebox) {
        
        if let currentTime = jukebox.currentItem?.currentTime, let duration = jukebox.currentItem?.meta.duration {
            
            currentItem.image = imageURLs[jukebox.playIndex]
            currentItem.title = itemTitles[jukebox.playIndex]
            let value = Float(currentTime )
           // slider.value = value
            sliderValue = Double(value)
          

            let mySecs = Int(value) % 60
            let myMins = Int(value / 60)
            currentTimeOfMusic = "\(myMins):\(mySecs)"
          //  var str = currentTimeOfMusic/60
            let mySecs2 = Int((jukebox.currentItem?.meta.duration)!) % 60
            let myMins2 = Int((jukebox.currentItem?.meta.duration)! / 60)
            durationTimeOfMusic  = "\(myMins2):\(mySecs2)"
           

            
            if shouldReload() {
                playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
                
                
            }
            
                 } else {
        }
    }
    
    func jukeboxStateDidChange(_ jukebox: Jukebox) {
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            jukeBoxState = jukebox.state
            
            self.playeTableView.reloadData()
               })
        
        if jukebox.state == .ready {
            playButtonImage = #imageLiteral(resourceName: "play-big-bold")
        } else if jukebox.state == .loading  {
            playButtonImage = #imageLiteral(resourceName: "pause-big-bold")
        } else {
            // volumeSlider.value = jukebox.volume
            var imageName: String
            switch jukebox.state {
            case .playing, .loading:
                imageName = "pause-big-bold"
                playButtonImage = #imageLiteral(resourceName: "pause-big-bold")
            case .paused, .failed, .ready:
                imageName = "play-big-bold"
                playButtonImage = #imageLiteral(resourceName: "play-big-bold")
            }
          //  playPauseButton.setImage(UIImage(named: imageName), for: UIControlState())
        }
        
        
//        if scrollOffset <= 0.0 {
//            
//            playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
//        }
        
        if shouldReload() {
            playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
            
            
        }
        
        
       // playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
        let processor = BlurImageProcessor(blurRadius: 5)
        playPageBackGrond.kf.setImage(with: URL(string: imageURLs[jukebox.playIndex]), placeholder: nil, options: [.processor(processor)], progressBlock: nil, completionHandler: nil  )
    }
    
    func jukeboxDidUpdateMetadata(_ jukebox: Jukebox, forItem: JukeboxItem) {
        

        if shouldReload() {
            playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
            
            
        }
      //  playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
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
    
  

    
    
    
    
    
    ///MARK: pannel protocol message 
    
    func playPanelBtn() {
        if jukeBoxState == .playing {
            jukebox.pause()
            
        }else{
            jukebox.play()
        }
        playingOrPause = true
        playeTableView.reloadData()
       
      

    }
    
    func pausePanelBtn() {
        if jukeBoxState == .playing {
            jukebox.pause()
            
        }else{
            jukebox.play()
        }
        playingOrPause = true
        playeTableView.reloadData()
    }
    
    func nextPanelBtn() {
          jukebox.playNext()
    }
    func prevPanelBtn() {
         jukebox.playPrevious()
    }
    func stopPanelBtn() {
        jukebox.stop()
    }

    
    func addFavoriteRes(statusCode: String) {
        if statusCode == "100"{
        alert(msg: "به علاقه مندی ها اضافه شد.")
        }
    }
    
    //nav buttons
    @IBAction func blurMenu(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.subListTableView.reloadData()
            self.blurMenuView.alpha = 1
            
            self.view.layoutIfNeeded()
        }, completion: nil)

        
    }
    @IBOutlet weak var currentMusicLabel: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
       //  _ = self.navigationController?.popViewController(animated: false)
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func likeButton(_ sender: Any) {
        let likeObject = AddToFavorite()
        likeObject.item_id = item_ids[jukebox.playIndex]
        likeObject.user_id = shared_User_Id
        
        netObject.addToFavorite(object: likeObject)
    }
    // MARK: - coment delegate methodes
    func getCommentForItem(object: GetComment, success: Bool) {
        if success{
            
        }else{
        
            alert2(msg: "error in connection..")
        }
    }
    
    func setCommentForItem(success: Bool) {
        
    }
    
    
    
    func addRelatedItems()  {
        
        do {
       
            
        var urlSTemp = [String]()
        var idSTemp = [String]()
        var imgSTemp = [String]()
        var itemTitlesTemp = [String]()
        idSTemp.append(playItem.id!)
        imgSTemp.append(playItem.image!)
        itemTitlesTemp.insert(playItem.title!, at: 0)
        var jukeItemArrTemp = [JukeboxItem]()
            if let url = playItem.file {
            jukeItemArrTemp.append( JukeboxItem(URL: URL(string: url)!))
            }
        
        if let item = playItem.related_items {
    for i in item {
        
                
        jukeItemArrTemp.append( JukeboxItem(URL: URL(string: i.file!)!))

            imgSTemp.append(i.image!)
            idSTemp.append(i.id!)
            itemTitlesTemp.append(i.title!)
        
        }
    
        
        
        }
            imageURLs = imgSTemp
            imgSTemp.removeAll()
            item_ids = idSTemp
            idSTemp.removeAll()
            itemTitles = itemTitlesTemp
            itemTitlesTemp.removeAll()
            jukeItemArr =  jukeItemArrTemp
            jukeItemArrTemp.removeAll()
          //  pannelImageUrl = imageURLs[0]
            self.playeTableView.delegate = self
            self.playeTableView.dataSource = self
            UIApplication.shared.beginReceivingRemoteControlEvents()
            
           // playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
            //let obj = Jukebox(delegate: self, items: jukeItemArr)!
            //let j = JukeBoxClass()
            
            if comparePlayItemIsNewOrNot() {
                
                if let d = jukebox.currentItem?.meta.duration {
                    // slider.maximumValue = Float(d)
                    sliderMaxValue = d
                    if  (playeTableView.contentSize.height < playeTableView.frame.size.height) {
                        
                    }
//                    if scrollOffset <= 0.0 {
//                        playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
//                    }
                    if shouldReload() {
                        playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
                        
                        
                    }
                    
                }
                playeTableView.reloadData()
                
                
                if let currentTime = jukebox.currentItem?.currentTime, let duration = jukebox.currentItem?.meta.duration {
                    
                    currentItem.image = imageURLs[jukebox.playIndex]
                    currentItem.title = itemTitles[jukebox.playIndex]
                    let value = Float(currentTime )
                    // slider.value = value
                    sliderValue = Double(value)
                    //           let home = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    //            home.pannelImageUrl = imageURLs[jukebox.playIndex]
                    //            home.showPlayPannel()
                    let mySecs = Int(value) % 60
                    let myMins = Int(value / 60)
                    currentTimeOfMusic = "\(myMins):\(mySecs)"
                    //  var str = currentTimeOfMusic/60
                    let mySecs2 = Int((jukebox.currentItem?.meta.duration)!) % 60
                    let myMins2 = Int((jukebox.currentItem?.meta.duration)! / 60)
                    durationTimeOfMusic  = "\(myMins2):\(mySecs2)"
//                    if scrollOffset <= 0.0 {
//                        
//                        playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
//                    }
                    if shouldReload() {
                        playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
                        
                        
                    }
                    
                    // populateLabelWithTime(currentTimeLabel, time: currentTime)
                    //  populateLabelWithTime(durationLabel, time: duration)
                }
                
            }else{
                if jukeBoxState == .playing {
                    // jukebox.stop()
                    jukebox.stop()
                }
                
                
            jukebox = Jukebox(delegate: self, items: jukeItemArr)!
                playObjCached.refererType = playObj.refererType
                playObjCached.id = playObj.id
                playObjCached.refererId = playObj.refererId
            }
           // cachedPlayItem = playItem
            
            playeTableView.reloadData()
            jukebox.play()
            
        }
        catch let e{
        print(e)
        
        }
        
        
        if let d = jukebox.currentItem?.meta.duration {
            // slider.maximumValue = Float(d)
            sliderValue = d
            if playItem.related_items?.count != 0 {
                playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
            }
            
        }
    }
    
    func comparePlayItemIsNewOrNot() -> Bool  {
        if playObj.refererType == "playlist" {
            if playObj.id == playObjCached.id{
            
            return true
            }else{
            
            return false
            }
        
        }else if  playObj.refererType == "vitrin" {
            if playObj.id == playObjCached.id && playObj.refererId == playObjCached.refererId {
                
                return true
            }else{
                
                return false
            }
        }else{
        return false
        }
    }
    
    func updateViewWithPlayingItem() {
        if let currentTime = jukebox.currentItem?.currentTime, let duration = jukebox.currentItem?.meta.duration {
            

            playPageBackGrond.kf.setImage(with: URL(string: (imageURLs[jukebox.playIndex])))
                
                    let value = Float(currentTime )
            // slider.value = value
            sliderValue = Double((jukebox.currentItem?.currentTime)!)
            

            
            if shouldReload() {
                playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
                
                
            }
        }
    }
    
    func previousFunction(){
        do {
            if let related = playItem.related_items {
                
                
                addRelatedItems()
                
            }
            if let myItem = playItem.file {
                imageURLs.append(playItem.image!)
                titleStringArray.append(playItem.id!)
                
                jukeItemArr.insert(JukeboxItem(URL: URL(string: myItem)!), at: 0)
                // item_ids.append(playItem.id!)
                item_ids.insert(playItem.id!, at: 0)
                itemTitles.insert(playItem.title!, at: 0)
                self.playeTableView.delegate = self
                self.playeTableView.dataSource = self
                playeTableView.reloadData()
                
            }
            
            if let tb = playItem.related_items {
                
                for i in tb {
                    item_ids.append(i.id!)
                    
                    
                }
                
                
                self.playeTableView.delegate = self
                self.playeTableView.dataSource = self
            }else{
                // alert2(msg: "error!")
                
            }
            
            UIApplication.shared.beginReceivingRemoteControlEvents()
            
            jukebox = Jukebox(delegate: self, items: jukeItemArr)!
            
            
            
        }
        catch{}
        if let d = jukebox.currentItem?.meta.duration {
            // slider.maximumValue = Float(d)
            sliderValue = d
            if playItem.related_items?.count != 0 {
                playeTableView.reloadSections([0,0], with: UITableViewRowAnimation.none)
            }
            
        }

    
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        endDragging = true
        isScrolling = false
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isScrolling = true
     scrollOffset = Double(scrollView.contentOffset.y)
        if  scrollView.isDecelerating {
        isDeclarating = true
            endDeclarating = false
        }
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        beginDeclarating = true
        endDeclarating = false
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        endDeclarating = true
        beginDeclarating = false
    }
    
    func blurViewImplementation() {
        

        
        
    }
    @IBAction func backBlurAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
//            
            self.blurMenuView.alpha = 0
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        //  blurView = false
    }
    var isScrolling = false
    var isDeclarating = false
    var endDeclarating = false
    var endDragging = false
    var beginDeclarating = true
    func shouldReload() -> Bool {
        
        guard !isScrolling else {
            return false
        }
        guard !isDeclarating else {
            return false
        }
        guard endDragging else {
            return false
        }
        
        
        
        
        
        return true
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
