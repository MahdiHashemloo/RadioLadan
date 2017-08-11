//
//  PlayListViewController.swift
//  RadioLadan
//
//  Created by nazanin hashemloo on 5/15/1396 AP.
//  Copyright © 1396 AP MHDY. All rights reserved.
//

import UIKit
import Jukebox
import Kingfisher
class PlayListViewController: BaseViewController,PlayListNetProtocol {
    @IBOutlet weak var playListTableView: UITableView!
    @IBOutlet weak var blurView2: UIView!
    @IBOutlet weak var playListNameTextField: UITextField!
    @IBOutlet weak var alertView: UIView!
    
    var netObject = NetworkManager()
    var PlayListData = GetPlayListResponse()
    var refererId = ""
    let getPlayList = GetSublist()
    var playerViewControllerObject = PlayerViewController()
    var addToPlayList = false
    var itemIdForAddToPlayList = "0"
    override func viewDidLoad() {
        super.viewDidLoad()

        blurView2.alpha = 0
        getPlayList.list_type = "playlist"
        getPlayList.user_id = shared_User_Id
        getPlayList.page = "0"
        getPlayList.num = "20"
        getPlayList.type = "sub_list"
        
        netObject.getPlayList(object: getPlayList)
        playPanelHeight.constant = 0
        if (jukeBoxState == Jukebox.State.playing) ||
            (jukeBoxState == Jukebox.State.paused){
            
            showPlayPannel()
        }else{
            hidePlayPannel()
        }

        netObject.playListNetDelegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        blurView2.alpha = 0
        getPlayList.list_type = "playlist"
        getPlayList.user_id = shared_User_Id
        getPlayList.page = "0"
        getPlayList.num = "20"
        getPlayList.type = "sub_list"
        
        netObject.getPlayList(object: getPlayList)
        playPanelHeight.constant = 0
        if (jukeBoxState == Jukebox.State.playing) ||
            (jukeBoxState == Jukebox.State.paused){
            
            showPlayPannel()
        }else{
            hidePlayPannel()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPlayListItems(res: GetPlayListResponse, isSuccess: Bool) {
        if isSuccess {
            PlayListData = res
            playListTableView.dataSource = self
            playListTableView.delegate = self
            playListTableView.reloadData()
        }

    }
    
    
    func createNiewPlaylistResponse(res: Bool) {
        if res {
            
            netObject.getPlayList(object: getPlayList)
        }else{
            alert2(msg: "error")
        }

    }
    
    
    func addToPlayListRes(res: CompleteInformationResponse) {
        dismiss(animated: true, completion: nil)
    }
    
    func getMusicFromVitrinDataResponse(res: GetMusicFromVitrinResponse) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        playItem = res
        // self.navigationController?.pushViewController(vc, animated: true)
        playerViewControllerObject.fromSongSelection = true
        present(playerViewControllerObject, animated: true, completion: nil)

    }
    @IBAction func blurMenu(_ sender: UIButton) {
        playListTableView.dataSource = self
        playListTableView.delegate = self
        playListTableView.reloadData()
        sublistTableView?.dataSource = self
        sublistTableView?.delegate  = self
        sublistTableView?.reloadData()
        showBlurMenu()
    }

    var fromMenu = false
    @IBAction func backButton(_ sender: UIButton) {
        if fromMenu {
            _ = navigationController?.popViewController(animated: true)
            fromMenu = false
        }else{
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func newPlayList(_ sender: UIButton) {
        
        blurView2.alpha = 1
        playListNameTextField.resignFirstResponder()
    }
    @IBAction func closeAlert(_ sender: UIButton) {
        playListNameTextField.text = ""
        blurView2.alpha = 0
        playListNameTextField.endEditing(true)

    }
    
    @IBAction func savePlayList(_ sender: UIButton) {
        if playListNameTextField.text! == ""{
            alert2(msg: "")
        }else{
            
            let playList = NewPlayList()
            playList.title = playListNameTextField.text!
            playList.user_id = shared_User_Id
            playList.type = "add_playlist"
            netObject.addNewPlayList(object: playList)
            
        }
        playListNameTextField.text = ""
        playListNameTextField.endEditing(true)
        blurView2.alpha = 0
        
    }
    
    
    
    //panelOutLets
    @IBOutlet weak var playPannelView: UIView!
    
    @IBOutlet weak var playPanelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var playButton : UIButton!
    
    @IBOutlet weak var panelImage: UIImageView!
    //MARK: - music pannel at home page:
    @IBOutlet weak var nameOfItem: UILabel!

    @IBAction func previousTrack(_ sender: UIButton) {
        jukebox.playPrevious()
        updatePanel()
      
          }
    
    @IBAction func nextTrack(_ sender: UIButton) {
        jukebox.playNext()
        updatePanel()
    }
    @IBAction func closePannel(_ sender: UIButton) {
        jukebox.stop()
        // playingOrPause = false
        hidePlayPannel()

    }
    
    
    @IBAction func playOrPause(_ sender: UIButton) {
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
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case sublistTableView!:
            return (subListData.items?.count)!
        default:
            if let counting = PlayListData.items?.count {
                return counting
            }else{
                return 3
            }
        }
       

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case sublistTableView!:
            switch indexPath.row {
            case 0:
                let HeaderCell = Bundle.main.loadNibNamed("HeaderSublistTableViewCell", owner: self, options: nil)?.last as!  HeaderSublistTableViewCell
                
                if islogedIn {
                    // cell.headerImage.kf.setImage(with: profileObj.)
                    HeaderCell.userNamelabel.text = " " + profileObj.fname! + " " + profileObj.lname!
                    HeaderCell.userEmailLabel.text = profileObj.email!
                    HeaderCell.userImage.image = #imageLiteral(resourceName: "profile")
                }else{
                    HeaderCell.userNamelabel .text = "میهمان"
                    HeaderCell.userEmailLabel .text = ""
                    HeaderCell.userImage.image = #imageLiteral(resourceName: "profile")
                    
                }
                HeaderCell.selectionStyle = .none
                
                return HeaderCell
            default:
                let itemCell = Bundle.main.loadNibNamed("SublistTableViewCell", owner: self, options: nil)?.last as!  SublistTableViewCell
                
                if let imgString = (subListData.items?[indexPath.row].image) {
                    let img = UIImageView()
                    img.kf.setImage(with:URL(string:imgString), placeholder: nil, options:[.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
                    
                    if let ssI = sublistSelectedIndex {
                        //                        if indexPath.row == ssI {
                        //
                        //                        itemCell.Icon.tintColor = UIColor.blue
                        //                        itemCell.label.textColor = UIColor.blue
                        //
                        //
                        //                        }
                        
                        
                    }
                    itemCell.Icon.setImage(img.image, for: .normal)
                    
                    itemCell.Icon.tintColor = UIColor.white
                    
                    itemCell.label.text = subListData.items?[indexPath.row].title
                    
                    //  cell.itemLabel.highlightedTextColor = UIColor.blue
                    
                }
                itemCell.selectionStyle = .none
                return itemCell
            }

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayListCell", for: indexPath) as! PlayListCell
            
            
            if let igmString = PlayListData.items?[indexPath.row].image {
                print(igmString)
                // cell.imageViewPlayList.kf.setImage(with: URL(string: "\(igmString)"))
                cell.imageViewPlayList.image = #imageLiteral(resourceName: "empty_photo")
                
            }
            if let txt = PlayListData.items?[indexPath.section].title {
                cell.playListName.text = (PlayListData.items?[indexPath.row].title)!
                
            }
            
            return cell
            
       
        

        }
        
      
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case sublistTableView!:
            sublistSelectedIndex = indexPath.row
            sublistTableView?.reloadData()
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
                let playListObj = storyboard?.instantiateViewController(withIdentifier: "PlayListController") as! PlayListController
                //  subListData.items?[indexPath.section].id
                playListObj.fromMenu = true
                
                self.navigationController?.pushViewController(playListObj, animated: true)
                
            }else{
                
                let detail = storyboard?.instantiateViewController(withIdentifier: "CatListItemController") as! CatListItemController
                navigationController?.pushViewController(detail, animated: true)
            }
            
            
        case playListTableView!:
            if addToPlayList {
                var playListitem = (PlayListData.items?[indexPath.row].id)!
                let addToPlaylist = AddToPlayList()
                addToPlaylist.playlist_id = playListitem
                addToPlaylist.content_id = itemIdForAddToPlayList
                addToPlaylist.user_id = shared_User_Id
                addToPlayList = false
                netObject.addToPlayList(object: addToPlaylist)
                
            }else{
                //{"type":"content_detail","id":"21","refferer_type":"playlist","refferer_id":"2","user_id":"20"}
                let contentDetail = GetMusicFromVitrin()
                contentDetail.user_id = shared_User_Id
                contentDetail.id = (PlayListData.items?[indexPath.row].id)!
                contentDetail.refferer_type = "playlist"
                playerViewControllerObject = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
                let playObjTemp = PlayItemObject()
                playObjTemp.refererType = "playlist"
                playObjTemp.id = (PlayListData.items?[indexPath.row].id)!
                playerViewControllerObject.playObj = playObjTemp
                netObject.getMusicDataFromVitrin(getMusicVitrinObject: contentDetail)
                
                
                
            }
            
            
        default:
            
            if addToPlayList {
                var playListitem = (PlayListData.items?[indexPath.row].id)!
                let addToPlaylist = AddToPlayList()
                addToPlaylist.playlist_id = playListitem
                addToPlaylist.content_id = itemIdForAddToPlayList
                addToPlaylist.user_id = shared_User_Id
                addToPlayList = false
                netObject.addToPlayList(object: addToPlaylist)
                
            }else{
                //{"type":"content_detail","id":"21","refferer_type":"playlist","refferer_id":"2","user_id":"20"}
                let contentDetail = GetMusicFromVitrin()
                contentDetail.user_id = shared_User_Id
                contentDetail.id = (PlayListData.items?[indexPath.row].id)!
                contentDetail.refferer_type = "playlist"
                playerViewControllerObject = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
                let playObjTemp = PlayItemObject()
                playObjTemp.refererType = "playlist"
                playObjTemp.id = (PlayListData.items?[indexPath.row].id)!
                playerViewControllerObject.playObj = playObjTemp
                netObject.getMusicDataFromVitrin(getMusicVitrinObject: contentDetail)
                
                
                
            }
            //vaghti select kard mibarimesh be safe pakhsh ba item ha
            
            
        }
        
        
        
        

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
