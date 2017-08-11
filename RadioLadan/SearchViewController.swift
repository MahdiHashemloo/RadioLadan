//
//  SearchViewController.swift
//  RadioLadan
//
//  Created by Apple on 6/5/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit
import Kingfisher
import Jukebox
class SearchViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,searchPr{

    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    
    
    //blurview outlrts:
    @IBOutlet weak var blurBackButton: UIButton!
    @IBOutlet weak var blurMenuView: UIView!
    
    @IBOutlet weak var subListTableView: UITableView!
    
    var tableViewData = GetPlayListResponse()
    
    let searchItemObj = SearchItem()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.subListTableView.delegate = self
        self.subListTableView.dataSource = self
        
        
         netObject.searchDelegate = self
        searchItemObj.user_id = shared_User_Id
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playPanelHeight.constant = 0
        if (jukeBoxState == Jukebox.State.playing) ||
            (jukeBoxState == Jukebox.State.paused){
            
            showPlayPannel()
        }else{
            hidePlayPannel()
        }
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = blurMenuView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurMenuView.addSubview(blurEffectView)
        blurMenuView.addSubview(blurBackButton)
        
        blurEffectView.addSubview(subListTableView)
        blurMenuView.alpha = 0
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        hidePlayPannel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == subListTableView {
        return 6
        }else{
        return (tableViewData.items?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == subListTableView {
            
            //blur view table:
            //subListItemCell
            //subListHeaderCell
            
            if indexPath.row == 0 {
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
                if let img = (subListData.items?[indexPath.row].image) {
                    cell.itemImage.kf.setImage(with:URL(string:img), placeholder: nil, options:[.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
                    cell.itemLabel.text = subListData.items?[indexPath.row].title
                    
                    //  cell.itemLabel.highlightedTextColor = UIColor.blue
                    
                }
                
                // cell.vitrinContent = vitrinData
                return cell
            }
            
            
        }else{
        
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
            if let txt = (tableViewData.items?[indexPath.row].image) {
                cell.itemImageView.kf.setImage(with: URL(string: (tableViewData.items?[indexPath.row].image)!))
                
            }
            if let txt =  tableViewData.items?[indexPath.row].album_name {
                cell.itemView.text = tableViewData.items?[indexPath.row].album_name!
            }
            if let txt =  tableViewData.items?[indexPath.row].duration {
                cell.durationLabel.text = txt
            }
            
            if let txt =  tableViewData.items?[indexPath.row].fav_num {
                cell.likedNumLabel.text = txt
            }
            
            if let txt =  tableViewData.items?[indexPath.row].comment_num {
                cell.commentNumLabel.text  = txt
            }
            if let txt =  tableViewData.items?[indexPath.row].title {
                cell.itemView.text  = txt
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        
        }
        
        
        
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == subListTableView {
            //{"type":"content_list","list_type":"cat,author,vitrin,playlist,genre","id":"1","user_id":"1","key_word":"","page":"0","num":"10"}
            
            //har cell ke select mishe id dare ke ba in API datash ro migirim
            if indexPath.row == 0 {
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
                
            }else if indexPath.row == 1 {
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
            
            
        }else{
            
            //search result table
            let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
            vc.fromSongSelection = true
            let playObjTemp = PlayItemObject()
            
            
            let nc = UINavigationController(rootViewController: vc)
            nc.isNavigationBarHidden = true
            // present(nc, animated: true, completion: nil)
            
            //.....
            let item = tableViewData.items?[indexPath.row]
            let itemObj = GetMusicFromVitrin()
            itemObj.type = "content_detail"
            itemObj.id = item?.id!
            itemObj.refferer_type = "cat"
            itemObj.refferer_id = ""
            netObject.getMusicDetail(getMusicVitrinObject: itemObj){
                (result) -> () in
                
                playObjTemp.image = result.image!
                playObjTemp.refererType = "cat"
                playObjTemp.id = (result.id)!
                
                vc.playObj = playObjTemp
                
                
                playItem = result
                self.present(nc, animated: true, completion: nil)
                
                
            }

            
            
        
        
        
        
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == subListTableView{
        //return 200
            if indexPath.row == 0{
            return 200
            }else{
            
            return 50
            }
        
        }else{
        return 125
        
        }
    }
    
    var blurView = false
    @IBAction func blurMenu(_ sender: Any) {
        
     //   if !blurView {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                
                self.blurMenuView.alpha = 1
                
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            
            
         //   blurView = true
//        }else{
//            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                
//                
//                self.blurMenuView.alpha = 0
//                
//                self.view.layoutIfNeeded()
//            }, completion: nil)
//            
//            blurView = false
//        }
        

        
    }
    
    
    @IBAction func backButtonBlurMenu(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            
            self.blurMenuView.alpha = 0
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        
       // blurView = false
    }
    
    
    @IBAction func backButton(_ sender: Any) {
      _ =  navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func searchFieldDidChange(_ sender: Any) {
        if (searchField.text?.characters.count)! > 2 {
            let newString = searchField.text?.replacingOccurrences(of: "ك", with: "ک")
            let newString2 = newString?.replacingOccurrences(of: "ي", with: "ی")
            
        
       
            searchItemObj.key_word = "\(newString2!)"
            netObject.searchItem(object: searchItemObj)
        }
        
    }
    
    func searchError(success: Bool) {
        
    }
    
    func searchResponse(res: GetPlayListResponse) {
        
        if let c = res.items?.count{
        tableViewData = res
            searchTableView.delegate = self
            searchTableView.dataSource = self
            searchTableView.reloadData()
        
        
        }
        
        
    }
    
    
    //pannel
    
    //panelOutLets
    @IBOutlet weak var playPannelView: UIView!
    @IBOutlet weak var playPanelHeight: NSLayoutConstraint!
    @IBOutlet weak var playButton : UIButton!
    @IBOutlet weak var panelImage: UIImageView!
    //MARK: - music pannel at home page:
    @IBOutlet weak var nameOfItem: UILabel!
    

    
    @IBAction func previousItem(_ sender: Any) {
        jukebox.playPrevious()
        updatePanel()
    }
    
    
    @IBAction func playOrPauseItem(_ sender: Any) {
        
        if(jukeBoxState == Jukebox.State.playing){
            playButton.alpha = 1
            playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            jukebox.pause()
            playingOrPause = true
            print("playing")
            PlayingMode = true
            
        }else if (jukeBoxState == Jukebox.State.paused){
            playButton.alpha = 1
            playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            playingOrPause = true
            print("paused")
            jukebox.play()
            
            
        }
        updatePanel()
        

    }
    
    @IBAction func nextItem(_ sender: Any) {
        jukebox.playNext()
        updatePanel()
        
    }
    
    @IBAction func closeButton(_ sender: Any) {
        
        jukebox.stop()
        // playingOrPause = false
        hidePlayPannel()

    }
   
   
    
    func showPlayPannel()  {
        print("showPlayPannel :\((currentItem.image)!)")
        print("showPlayPannel :\((currentItem.title)!)")
        let processor = BlurImageProcessor(blurRadius: 2)
        //pannelImageUrl
        panelImage.kf.setImage(with: URL(string: "\((currentItem.image)!)"), placeholder: nil, options: [.processor(processor)], progressBlock: nil, completionHandler: nil  )
        
        // panelImage.kf.setImage(with: URL(string: "\((currentItem.image)!)"))
        nameOfItem.text = "\((currentItem.title)!)"
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            
            self.playPanelHeight.constant = 50
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        
        playPannelView.alpha = 1
    }
    func updatePanel() {
        let processor = BlurImageProcessor(blurRadius: 2)
        panelImage.kf.setImage(with: URL(string: "\((currentItem.image)!)"), placeholder: nil, options: [.processor(processor)], progressBlock: nil, completionHandler: nil  )
        
        // panelImage.kf.setImage(with: URL(string: "\((currentItem.image)!)"))
        nameOfItem.text = "\((currentItem.title)!)"
    }
    
    func hidePlayPannel() {
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            
            self.playPanelHeight.constant = 0
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        playPannelView.alpha = 0
    }
    
    @IBAction func goToPlayerPage(_ sender: Any) {
        //        let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        //        present(vc, animated: true, completion: nil)
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
