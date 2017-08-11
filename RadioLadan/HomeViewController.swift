//
//  HomeViewController.swift
//  RadioLadan
//
//  Created by Apple on 4/25/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit
import Kingfisher
import NVActivityIndicatorView
import Jukebox
protocol pannelProtocol {
    func playPanelBtn()
    func pausePanelBtn()
    func nextPanelBtn()
    func prevPanelBtn()
    func stopPanelBtn()
}


var subListData = GetSublistresponse()
var profileObj = GetProfileResponse()
let netObject = NetworkManager()
var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
}
class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,getVitrinDataPr,HeaderTableViewCellDelegate ,HomeTODetail,ProfilePr,content_list_pr{
    //sublist
    var pannelImageUrl = ""
    
    
    
    
    @IBOutlet weak var backBlurButton: UIButton!
    let playObjTemp = PlayItemObject()
    
    var isPlaying = false
    var panelDelegate:pannelProtocol?
    @IBOutlet weak var blurMenuView: UIView!
    
    @IBOutlet weak var subListTableView: UITableView!
    
    @IBOutlet weak var activity: NVActivityIndicatorView!
    
    
    //panelOutLets
    @IBOutlet weak var playPannelView: UIView!
    @IBOutlet weak var playPanelHeight: NSLayoutConstraint!
    @IBOutlet weak var playButton : UIButton!
    @IBOutlet weak var panelImage: UIImageView!
    
    
    //
    var blurView = false
    let netObject = NetworkManager()
    var vitrinData = vitrinResponse()
    
    
    var  refreshController = UIRefreshControl()
    
    @IBOutlet weak var homePageTableView: UITableView!
    func listFonts()
    {
        for name in UIFont.familyNames
        {
            print(name)
            print(UIFont.fontNames(forFamilyName: name))
        }
    }
    override func viewDidLoad() {
        listFonts()
      homePageTableView.separatorColor = UIColor.clear
        self.homePageTableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
//        self.homePageTableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0.01)
       self.automaticallyAdjustsScrollViewInsets = false
        
        netObject.getContentListDelegate = self
        refreshController.frame = CGRect(x: 0, y: 60, width: 30, height: 30)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = blurMenuView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurMenuView.addSubview(blurEffectView)
        
        blurEffectView.addSubview(subListTableView)
        blurEffectView.addSubview(backBlurButton)
        blurMenuView.alpha = 0
     
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
   
        playPanelHeight.constant = 0
        activity.type = NVActivityIndicatorType.ballPulse
        super.viewDidLoad()
        netObject.getVitrinDataDelegate = self
        netObject.getProfileDelegate = self
////        let uiDevice = UIDevice.current.name
//        let uuid = UIDevice.current.identifierForVendor!.uuidString
//        print(uuid)
        
        getMenuList()
  
               checkLogIn()
        if (jukeBoxState == Jukebox.State.playing) ||
        (jukeBoxState == Jukebox.State.paused){
        
        showPlayPannel()
        }else{
        hidePlayPannel()
        }
        
        var timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(checkConnection), userInfo: nil, repeats: true)
        
              

    }
    
    func pullToRefresh() {
    
        refreshController.endRefreshing()
        let getvitrinObj = GetVitrin()
        netObject.getVitrinData(getVitrinObject: getvitrinObj)
    }
    
    func checkConnection()  {
        if !(netObject.isInternetAvailable()){
        alert2(msg: "عدم اتصال به اینترنت")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
      UIApplication.shared.statusBarStyle = .lightContent
        let getvitrinObj = GetVitrin()
        netObject.getVitrinData(getVitrinObject: getvitrinObj)
       //play pannel
        // if is not playing
        hidePlayPannel()
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == subListTableView {
         return (subListData.items?.count)!
        }else{
         return 6
        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == subListTableView {
            return 1
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //cell.MusicCollectionView.reloadData()
        
        if (tableView == homePageTableView){
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "VitrinCell", for: indexPath) as! VitrinCell
           // cell.carousel.delegate = self
           // cell.vitrinContent = vitrinData
            return cell
        
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "vitrinCollectionCell", for: indexPath) as! VitrinCell
            // cell.vitrinContent = vitrinData
            if let data = (vitrinData.vitrins?[0]) {
                cell.vitrinObject = (vitrinData.vitrins?[0])!
                cell.sectionNum = Int((vitrinData.vitrins?[0].id)!)!
                cell.sectionIndex = 0
                cell.MusicCollectionView.reloadData()
                cell.HomeTODetailDelegate = self
                
                cell.separatorView.alpha = 1
            
            }
          
            return cell
            
        }else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "vitrinCollectionCell", for: indexPath) as! VitrinCell
            // cell.vitrinContent = vitrinData
            cell.vitrinObject = (vitrinData.vitrins?[1])!
            cell.sectionNum = Int((vitrinData.vitrins?[1].id)!)!
            cell.sectionIndex = 1
            cell.MusicCollectionView.reloadData()
            cell.HomeTODetailDelegate = self
            cell.separatorView.alpha = 1
            return cell
            
        }else if indexPath.section == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: "vitrinCollectionCell", for: indexPath) as! VitrinCell
            // cell.vitrinContent = vitrinData 
            
            if vitrinData.vitrins?.count != 0 {
            if let vitrinobject = (vitrinData.vitrins?[2]){
            
            cell.vitrinObject = (vitrinData.vitrins?[2])!
            }
            
            if let  sectionNum = (vitrinData.vitrins?[2].id){
            
            cell.sectionNum = Int((vitrinData.vitrins?[2].id)!)!
                
                }
            }
            
            
            cell.sectionIndex = 2
            cell.MusicCollectionView.reloadData()
            cell.HomeTODetailDelegate = self
            cell.separatorView.alpha = 0
            return cell
            
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "vitrinImageCell", for: indexPath) as! VitrinCell
            // cell.vitrinContent = vitrinData
            if  0 != vitrinData.inline_banners?.count {
                print(vitrinData.toJSON())  
                if let img = vitrinData.inline_banners?[0].image {
                    cell.imageBetweenCells.kf.setImage(with: URL(string: (img)))
                    
                    
                }else {
                
                cell.imageBetweenCells.image = #imageLiteral(resourceName: "empty_photo")
                
                
                }
                if let title = vitrinData.inline_banners?[0].title {
                    
                    cell.titleLabel.text = title
                    
                }

            }else{
                
                
            
            }
                      // cell.separatorView.alpha = 1
            
            return cell
            
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "vitrinImageCell", for: indexPath) as! VitrinCell

            
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
    //header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == homePageTableView {
            let header = tableView.dequeueReusableCell(withIdentifier: "header") as! HeaderTableViewCell
            
            if section == 1 {
               // vitrinData.vitrins?[0].id
                
                header.sectionHeaderLabel.text = vitrinData.vitrins?[0].title!

                header.header_Id = (vitrinData.vitrins?[0].id)!
            }else if section == 3 {
            header.sectionHeaderLabel.text = vitrinData.vitrins?[1].title!
                header.header_Id = (vitrinData.vitrins?[1].id)!
            } else if section == 5 {
            header.sectionHeaderLabel.text = vitrinData.vitrins?[2].title!
                header.header_Id = (vitrinData.vitrins?[2].id)!
            
            }
            
            //|| section == 5
        if section == 1 || section == 3 || section == 5 {
            header.loadMoreLabel.text = "همه"
            
            let arr = [0,0,1,1,2,2,2]
            header.sectionHeaderLabel.text = (vitrinData.vitrins?[arr[section]].title)!
            
            header.delegate = self
            header.sectionNumber = section
           
        }else{
            header.loadMoreLabel.text = ""
        }
            return header
        
        }else{
            
            let header = tableView.dequeueReusableCell(withIdentifier: "subListItemCell") as! SubListCell
        header.itemLabel.text = ""
        return header
        }
            
      
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if tableView == homePageTableView {
        return 1
        }else{
        return 1
        
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if tableView == homePageTableView{
        
        if section == 0 {
        return 0
        }
        
        if section == 1 || section == 3 || section == 5{
            return 30
            
        }else{
            return 1
        }
    }else
       {
            return 1
        }

    }
    //header view delegate method:
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if tableView == subListTableView{
        view.backgroundColor = UIColor.clear
        view.tintColor = UIColor.clear
            view.alpha = 0
        }
    }
    func didSelectUserHeaderTableViewCell(Selected: Bool, UserHeader: HeaderTableViewCell) {
//        print("Cell Selected! \(UserHeader.sectionNumber) \(UserHeader.cityId)");
       print("hi")
        //vaghti heaer ra entekhab kard,ba asase section num mre be safe moshahede hame
     
        let contentListObj = storyboard?.instantiateViewController(withIdentifier: "CatListItemController") as! CatListItemController

        contentListObj.header_id = UserHeader.header_Id
      
        
        let getContent_list = GetContentList()
       
        getContent_list.user_id = shared_User_Id
        getContent_list.num = "50"
       
       // netObject.getContentList(object: getContent_list)
        navigationController?.pushViewController(contentListObj, animated: true)
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFade
        // self.navigationController?.view.layer.add(transition, forKey: nil)
      
        //applySearchFilters()
        
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
        
        subListTableView.reloadData()
    }
    
    //MARK: - collection view selection delegate:
    func goToDetailFromHome(itemIndex: Int,secttion:Int) {
        
        //jukebox.stop()
        if (jukeBoxState == Jukebox.State.playing){
        
        //jukebox.stop()
        }else if (jukeBoxState == Jukebox.State.paused){
       // jukebox.stop()
        }
        _ = [0,0,0,1,1,2]
        let getMusic = GetMusicFromVitrin()
        getMusic.id = "\(((vitrinData.vitrins?[secttion].items?[itemIndex])?.id)!)"
        getMusic.refferer_id = "\(secttion)"
        playObjTemp.refererId = "\(secttion)"
       // let playerPageObj = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
       
        
        
        netObject.getMusicDataFromVitrin(getMusicVitrinObject: getMusic)
        activity.startAnimating()
        
     
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == homePageTableView
        {
         if indexPath.section == 0 {
         return 150
            
            
         }else if indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 5
         {
            return 150
         }else if indexPath.section == 2
         {
           // if  0 != vitrinData.inline_banners?.count {
                  return 180
            
          //  }else{
                
           //       return 0
                
          //  }
          
            
         }else{
            return 180
            
            }
        
         }else{
            if indexPath.section == 0 {
            
             return self.view.frame.size.height/3
            }else{
         return 50
            }
         
    }
    
    }
    //networkDelegate
    func getVitrinDataResponse(res: vitrinResponse) {
        if res.message == "Operation was succsessful." {
       
            vitrinData = res
            vitrinContent = res
            print("banners:\(vitrinData.banners?.count)")
            var temp = [String]()
            for i in vitrinData.banners! {
            temp.append(i.image!)
                print(i.image)
            
            }
            bannerImageURLs = temp
            temp.removeAll()

            homePageTableView.dataSource = self
            homePageTableView.delegate = self
            
            if #available(iOS 10.0, *) {
                homePageTableView.refreshControl = refreshController
            } else {
                // Fallback on earlier versions
            }
            refreshController.tintColor = UIColor.white
            refreshController.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)

            homePageTableView.reloadData()
 
        }else{
        
            
        //netWork problem!
        
        }
    }
    
    func getMusicFromVitrinDataResponse(res : GetMusicFromVitrinResponse){
    
        activity.stopAnimating()
        let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        playItem = res
       // self.navigationController?.pushViewController(vc, animated: true)
        vc.fromSongSelection = true
        
        playObjTemp.image = res.image!
        playObjTemp.refererType = "vitrin"
        playObjTemp.id = (playItem.id)!
        
        vc.playObj = playObjTemp
    
        let nc = UINavigationController(rootViewController: vc)
        nc.isNavigationBarHidden = true
        present(nc, animated: true, completion: nil)
    
    
    }
    func getSublistData(res: GetSublistresponse) {
        subListData = res
        print("res.items?.count\(res.items?.count)")
        subListTableView.dataSource = self
        subListTableView.delegate = self
        subListTableView.reloadData()
    }
    func getMenuList() {
       let getSublistObj = GetSublist()
        
        netObject.getSublistItems(getSubListObject: getSublistObj)
    }
    
    @IBAction func rightMenu(_ sender: Any) {
 
        if !blurView {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                
               self.blurMenuView.alpha = 1
                
                self.view.layoutIfNeeded()
            }, completion: nil)

            
            
            blurView = true
        }else{
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                
                self.blurMenuView.alpha = 0
                
                self.view.layoutIfNeeded()
            }, completion: nil)

            blurView = false
        }
        

        
      
    }
    
    func getUserData() {
        let getProfileObj = GetProfile()
        
    }
    //MARK: - music pannel at home page:
    @IBOutlet weak var nameOfItem: UILabel!
    
    @IBAction func previousItem(_ sender: Any) {
      //  panelDelegate?.prevPanelBtn()
        
        jukebox.playPrevious()
        updatePanel()
    }
    @IBAction func playOrPauseItem(_ sender: Any) {
    //    jukebox.play()
//        if (jukeBoxState == Jukebox.State.playing) {
//            
//           // playingOrPause = false
//      // panelDelegate?.pausePanelBtn()
//        }else{
//            jukebox.play()
//           // playingOrPause = true
//       // panelDelegate?.playPanelBtn()
//        }
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
       // panelDelegate?.nextPanelBtn()
        jukebox.playNext()
        updatePanel()
    }

    @IBAction func closeButton(_ sender: Any) {
       // panelDelegate?.stopPanelBtn()
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
 
    
    //MARK: - get content_list for see all
    //{"type":"content_list","list_type":"cat,author,vitrin,playlist,genre","id":"1","user_id":"1","key_word":"","page":"0","num":"10"}
    
   
    func getContentlistRes(res: GetContentListResponse) {
        let contentListObj = storyboard?.instantiateViewController(withIdentifier: "CatListItemController") as! CatListItemController
        contentListObj.contentListData = res
        navigationController?.pushViewController(contentListObj, animated: true)
    }
    
    func getContentlistResFailed(err: String) {
        alert(msg: "خطا در اتصال")
    }
    
    
    
    
    
    
    func checkLogIn()  {
     
        if let IsLogedIn = defaults.value(forKey: "isLogin")
        {
            
            if IsLogedIn as! Bool {
                
                print(IsLogedIn)
                islogedIn = true
                let pf = GetProfile()
                let userId = defaults.value(forKey: "user_id")
                pf.user_id = "\(userId!)"
            shared_User_Id = "\(userId!)"
                
                netObject.getProfileUser(object: pf)
            }else{
                islogedIn = false
            }
            
            
        }else{
            islogedIn = false
            
        }
    }
    
    
    func getProfileResponse(res: GetProfileResponse) {
        profileObj = res
        subListTableView.reloadData()
    }
    
    

  
    @IBAction func groupedMenuAction(_ sender: Any) {
        
      //  if !blurView {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                
                self.blurMenuView.alpha = 1
                
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            
            
       //     blurView = true
      //  }else{
//            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                
//                
//                self.blurMenuView.alpha = 0
//                
//                self.view.layoutIfNeeded()
//            }, completion: nil)
//            
         //   blurView = false
      //  }
        
        
        
        
    }
    
    
    @IBAction func backButtonBlurMenu(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            
            self.blurMenuView.alpha = 0
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        
      //  blurView = false
    }
    
    
    @IBAction func search_Home_Action(_ sender: Any) {
        let searchController = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        navigationController?.pushViewController(searchController, animated: true)
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

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
 
}




extension UIViewController {
    func alert2(msg : String)  {
        let myAttribute = [ NSFontAttributeName: UIFont(name: "IRANSansFaNum-Light", size: 18.0)! ]
        let myAttribute2 = [ NSFontAttributeName: UIFont(name: "IRANSansFaNum-Light", size: 14)! ]
        let myAttrString = NSAttributedString(string: "رادیو لادن", attributes: myAttribute)
        let attrMessage = NSAttributedString(string: msg, attributes: myAttribute2)
        let refreshAlert = UIAlertController(title: "Refresh", message: "لبای ستس تس ست", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.setValue(myAttrString, forKey: "attributedTitle")
        refreshAlert.setValue(attrMessage, forKey: "attributedMessage")
        
        //        refreshAlert.addAction(UIAlertAction(title: "دوربین", style: .default, handler: { (action: UIAlertAction!) in
        //
        //
        //
        //            print("Handle Ok logic here")
        //        }))
        let action = UIAlertAction(title: "باشه", style: .default, handler: { (action: UIAlertAction!) in
            
            
            
            print("Handle Cancel Logic here")
        })
        
        //  self.hideActivityIndicator(uiView: view)
        refreshAlert.addAction(action)
        
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    
    func alert(msg : String)  {
        let myAttribute = [ NSFontAttributeName: UIFont(name: "IRANSansFaNum-Light", size: 18.0)! ]
        let myAttribute2 = [ NSFontAttributeName: UIFont(name: "IRANSansFaNum-Light", size: 14)! ]
        let myAttrString = NSAttributedString(string: "رادیو لادن", attributes: myAttribute)
        let attrMessage = NSAttributedString(string: msg, attributes: myAttribute2)
        let refreshAlert = UIAlertController(title: "Refresh", message: "لبای ستس تس ست", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.setValue(myAttrString, forKey: "attributedTitle")
        refreshAlert.setValue(attrMessage, forKey: "attributedMessage")
        
        //        refreshAlert.addAction(UIAlertAction(title: "دوربین", style: .default, handler: { (action: UIAlertAction!) in
        //
        //
        //
        //            print("Handle Ok logic here")
        //        }))
        let action = UIAlertAction(title: "باشه", style: .default, handler: { (action: UIAlertAction!) in
            
            
            if(netObject.isInternetAvailable()){
                
                
                //availble:
                if let IsLogedIn = defaults.value(forKey: "isLogin")
                {
                    
                    if IsLogedIn as! Bool {
                        
                        print(IsLogedIn)
                        islogedIn = true
                        let pf = GetProfile()
                        let userId = defaults.value(forKey: "user_id")
                        pf.user_id = "\(userId!)"
                        netObject.getProfileUser(object: pf)

                    }else{
                        islogedIn = false
                    }
                    
                    
                }else{
                    islogedIn = false
                    
                }
                //getData:
//                netObject.getVitrinDataDelegate = self
//                netObject.getProfileDelegate = self
                let getSublistObj = GetSublist()
                
                netObject.getSublistItems(getSubListObject: getSublistObj)
                
                
                let getvitrinObj = GetVitrin()
                netObject.getVitrinData(getVitrinObject: getvitrinObj)
                
            }else
            {
                //not available
                
                self.alert(msg: "لطفا به اینترنت متصل شوید.")
                print("no netWork!")
            }
            
            print("Handle Cancel Logic here")
        })
        
      //  self.hideActivityIndicator(uiView: view)
        refreshAlert.addAction(action)
        
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    

    
    
    
    
    
}

