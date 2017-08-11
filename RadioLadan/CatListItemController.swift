//
//  CatListItemController.swift
//  RadioLadan
//
//  Created by Apple on 5/12/17.
//  Copyright © 2017 MHDY. All rights reserved.
//  "IRANSansFaNum-Light"
////popular//newest//most_view
import UIKit
import Segmentio
import NVActivityIndicatorView
import Jukebox
import Kingfisher
class CatListItemController: BaseViewController,content_list_pr {
    @IBOutlet weak var segmentIoView: Segmentio!
    @IBOutlet weak var activityBackView: UIView!
    @IBOutlet weak var activity: NVActivityIndicatorView!

    
    var refreshController = UIRefreshControl()
    let getContent_list = GetContentList()
    var header_id = ""
    @IBOutlet weak var contentListTableView: UITableView!
    var contentListData = GetContentListResponse()
    
    var font = UIFont()
    override func viewDidLoad() {
        super.viewDidLoad()
        listFonts()
        activityInit()
        contentListTableView.dataSource = self
        netObject.getContentListDelegate = self
        contentListTableView.delegate = self
        font = UIFont(name: "IRANSansFaNum-Light", size: 15)!
        segmentIoImplementation()
        getContent_list.id = header_id
        getContent_list.user_id = shared_User_Id
        getContent_list.num = "10"
        getContent_list.sort_type = "most_view"
        activityStartAnimating()
        if #available(iOS 10.0, *) {
            contentListTableView.refreshControl = refreshController
        } else {
            // Fallback on earlier versions
        }
        refreshController.tintColor = UIColor.white
        refreshController.addTarget(self, action: #selector(controllEvent), for: .valueChanged)
        netObject.getContentList(object: getContent_list)
    // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hidePlayPannel()
    }
    
    func controllEvent()  {
        refreshController.endRefreshing()
        getContent_list.id = header_id
        getContent_list.user_id = shared_User_Id
        getContent_list.num = "50"
        getContent_list.sort_type = "most_view"
        activityStartAnimating()
        netObject.getContentList(object: getContent_list)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playPanelHeight.constant = 0
        if (jukeBoxState == Jukebox.State.playing) ||
            (jukeBoxState == Jukebox.State.paused){
            
            showPlayPannel()
        }else{
            hidePlayPannel()
        }

       

    }
    
    func segmentIoImplementation() {
        
        var content = [SegmentioItem]()
        let tornadoItem1 = SegmentioItem(
            title:"ویژه",
            image: UIImage(named: " ")
        )
        let tornadoItem2 = SegmentioItem(
            title:"محبوب ترین",
            image: UIImage(named: " ")
        )
        let tornadoItem3 = SegmentioItem(
            title:"جدید ترین",
            image: UIImage(named: " ")
        )
        

        content.append(tornadoItem1)
        content.append(tornadoItem2)
        content.append(tornadoItem3)
        self.segmentIoView.setup(content: content, style: SegmentioStyle.onlyLabel, options:SegmentioOptions(backgroundColor: .clear, maxVisibleItems: 3, scrollEnabled: true, indicatorOptions: SegmentioIndicatorOptions.init(type: .bottom, ratio: 0.5, height: 2, color: .white), horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions.init(type: .bottom, height: 1, color: .clear), verticalSeparatorOptions: SegmentioVerticalSeparatorOptions.init(ratio: 1, color: .clear), imageContentMode: .center, labelTextAlignment: .center, labelTextNumberOfLines: 1, segmentStates: SegmentioStates(
            defaultState: SegmentioState(
                backgroundColor: .clear,
                titleFont: self.font ,
                titleTextColor: .white
            ),
            selectedState: SegmentioState(
                backgroundColor: .clear,
                titleFont: self.font,
                titleTextColor: .white
            ),
            highlightedState: SegmentioState(
                backgroundColor: UIColor.lightGray.withAlphaComponent(0.6),
                titleFont: self.font,
                titleTextColor: .white
        )), animationDuration: CFTimeInterval(0.4)))
        
        
        segmentIoView.valueDidChange = { segmentio, segmentIndex in
            print("Selected item: ", segmentIndex)
        self.contentListData.items?.removeAll()
            self.activityStartAnimating()
            if segmentIndex == 0 {
                self.getContent_list.id = self.header_id
                self.getContent_list.user_id = "\(shared_User_Id)"
                self.getContent_list.num = "50"
                self.getContent_list.sort_type = "popular"
                netObject.getContentList(object: self.getContent_list)
                
                
            }else if segmentIndex == 1{
            //newest
                self.getContent_list.id = self.header_id
                self.getContent_list.user_id = "\(shared_User_Id)"
                self.getContent_list.num = "50"
                self.getContent_list.sort_type = "newest"
                netObject.getContentList(object: self.getContent_list)
                
                
            }else {
            //most_view
                self.getContent_list.id = self.header_id
                self.getContent_list.user_id = "\(shared_User_Id)"
                self.getContent_list.num = "50"
                self.getContent_list.sort_type = "most_view"
                netObject.getContentList(object: self.getContent_list)
                
                
            }
            
            
            
            
        }
        
        
        
    }
    func listFonts()
    {
        for name in UIFont.familyNames
        {
            print(name)
            print(UIFont.fontNames(forFamilyName: name))
        }
    }

    
    //MARK: - table view methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case sublistTableView!:
            return (subListData.items?.count)!
        default:
            return (contentListData.items?.count)!

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
            let cell = tableView.dequeueReusableCell(withIdentifier: "CatItemCell", for: indexPath) as! CatItemCell
            
            if let img = contentListData.items?[indexPath.row].image {
                cell.imageViewForCell.kf.setImage(with: URL(string: "\(img)"))
                
                
                
                if let duration = (contentListData.items?[indexPath.row].duration)  {
                    cell.durationTimeLabel.text = duration
                    
                }else{
                    cell.durationTimeLabel.text = "02:00"
                }
                //   print("(contentListData.items?[indexPath.row].fav_num)\((contentListData.items?[indexPath.row].fav_num))")
                if let favNum = (contentListData.items?[indexPath.row].fav_num){
                    cell.likeNum.text = favNum
                    
                }else{
                
                  cell.likeNum.text = "0"
                }
                
                if let comentNum = (contentListData.items?[indexPath.row].comment_num){
                    cell.commentNum.text = comentNum
                }else{
                    cell.commentNum.text = "0"
                }
                
                
                cell.itemTitleLabel.text = (contentListData.items?[indexPath.row].title)
                
            }
            
            
            return cell

        }
        
           }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == sublistTableView
        {
            
            if indexPath.row == 0
            {
                
                return self.view.frame.size.height/3
            }else
            {
                return 50
            }
            
        }else{
            return 150
            
        }
    }
    
    override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //....
        print(indexPath.row)
        
        switch tableView {
        case sublistTableView!:
            //har cell ke select mishe id dare ke ba in API datash ro migirim
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
                let playListObj = storyboard?.instantiateViewController(withIdentifier: "PlayListViewController") as! PlayListViewController
                //  subListData.items?[indexPath.section].id
                playListObj.fromMenu = true
                
                self.navigationController?.pushViewController(playListObj, animated: true)
                
            }else{
                
                let detail = storyboard?.instantiateViewController(withIdentifier: "CatListItemController") as! CatListItemController
                navigationController?.pushViewController(detail, animated: true)
            }
        //che safe e?
        default:
            let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
            vc.fromSongSelection = true
            let playObjTemp = PlayItemObject()
            
            
            let nc = UINavigationController(rootViewController: vc)
            nc.isNavigationBarHidden = true
            // present(nc, animated: true, completion: nil)
            
            //.....
            let item = contentListData.items?[indexPath.row]
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
// MARK: - get content list 
    func getContentlistRes(res: GetContentListResponse) {
        contentListData = res
        
        if let data = contentListData.items {
        
            self.contentListTableView.reloadData()
            self.contentListTableView.scrollsToTop = true
            
        }
        sublistTableView?.reloadData()
        
         activityStopAnimating()
    }
    
    func getContentlistResFailed(err: String) {
        alert(msg: "error in connection")
    }
    
    @IBAction func menuBlur(_ sender: Any) {
        
        sublistTableView?.dataSource = self
        sublistTableView?.delegate  = self
        sublistTableView?.reloadData()
        showBlurMenu()
        
        
    }
    
    
    @IBAction func backButton(_ sender: Any) {
    _ = navigationController?.popViewController(animated: true)
    }
    
    func activityInit()  {
        activity.type = NVActivityIndicatorType.ballPulse
    }
    func activityStartAnimating() {
        activity.startAnimating()
        activityBackView.alpha = 1
    }
    func activityStopAnimating() {
        activity.stopAnimating()
        activityBackView.alpha = 0
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
