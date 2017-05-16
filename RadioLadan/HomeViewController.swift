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
class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,getVitrinDataPr,HeaderTableViewCellDelegate ,HomeTODetail{
    //sublist
    @IBOutlet weak var blurMenuView: UIView!
    
    @IBOutlet weak var subListTableView: UITableView!
    
    @IBOutlet weak var activity: NVActivityIndicatorView!
    
    @IBOutlet weak var playPanelHeight: NSLayoutConstraint!
    
    
    //
    var blurView = false
    let netObject = NetworkManager()
    var vitrinData = vitrinResponse()
    var subListData = GetSublistresponse()
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
        activity.type = NVActivityIndicatorType.ballPulse
        super.viewDidLoad()
        netObject.getVitrinDataDelegate = self
        
        let getvitrinObj = GetVitrin()
        netObject.getVitrinData(getVitrinObject: getvitrinObj)
        let uiDevice = UIDevice.current.name
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        print(uuid)
        
        getMenuList()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurMenuView.addSubview(blurEffectView)
        
        blurEffectView.addSubview(subListTableView)
        blurMenuView.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //check if playing ,hidden or show play pannel,use delegate for controll player at play viewcontroller
       // netObject.uploadMusic()
      //  netObject.upload2()
    }
    override func viewWillAppear(_ animated: Bool) {
        
       
        
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        // 2
        let nav = self.navigationController?.navigationBar
        nav?.isTranslucent = true
        nav?.barStyle = UIBarStyle.blackTranslucent        // 3
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))

//        if !islogedIn{
//            let phoneNumberController = self.storyboard?.instantiateViewController(withIdentifier: "PhoneNumberController") as! PhoneNumberController
//            navigationController?.pushViewController(phoneNumberController, animated: false)
//         //   present(phoneNumberController, animated: false, completion: nil )
//        }
        
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
           // cell.vitrinContent = vitrinData
            return cell
        
        }else if ( indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 5){
            let cell = tableView.dequeueReusableCell(withIdentifier: "vitrinCollectionCell", for: indexPath) as! VitrinCell
            if indexPath.section == 1 {
            cell.vitrinObject = (vitrinData.vitrins?[0])!
                cell.sectionNum = 1
            }else if indexPath.section == 3{
            cell.vitrinObject = (vitrinData.vitrins?[1])!
                cell.sectionNum = 3
            } else if indexPath.section == 5{
            cell.vitrinObject = (vitrinData.vitrins?[2])!
                cell.sectionNum = 5
            }
            
            cell.MusicCollectionView.reloadData()
            cell.HomeTODetailDelegate = self
            // cell.vitrinContent = vitrinData
            return cell
            
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "vitrinImageCell", for: indexPath) as! VitrinCell
            // cell.vitrinContent = vitrinData
            if let img = vitrinData.inline_banners?[0].image {
                cell.imageBetweenCells.kf.setImage(with: URL(string: (img)))
                
                
            }
            return cell
            
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "vitrinImageCell", for: indexPath) as! VitrinCell
//            if let img = vitrinData.inline_banners?[1].image {
//            cell.imageBetweenCells.kf.setImage(with: URL(string: (img)))
            
          //  }
//            cell.imageBetweenCells.kf.setImage(with: URL(string: (vitrinData.inline_banners?[1].image)!))
            //print( URL(string: (vitrinData.inline_banners?[1].image)!))
            // cell.vitrinContent = vitrinData
            
            return cell
            
            }
        
        }else{
        
            //blur view table:
            //subListItemCell
            //subListHeaderCell
            if indexPath.section == 0 {
                //header
                let cell = tableView.dequeueReusableCell(withIdentifier: "subListHeaderCell", for: indexPath) as! SubListCell
                // cell.vitrinContent = vitrinData
                return cell
            }else{
                //item
                let cell = tableView.dequeueReusableCell(withIdentifier: "subListItemCell", for: indexPath) as! SubListCell
                if let img = (subListData.items?[indexPath.section].image) {
                   cell.itemImage.kf.setImage(with:URL(string:img), placeholder: nil, options:[.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
                    cell.itemLabel.text = subListData.items?[indexPath.section].title
                
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
        if section == 1 || section == 3 || section == 5{
            header.loadMoreLabel.text = "hhhf"
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
        if section == 1 || section == 3 || section == 5{
            return 40
        }else{
            return 1
        }
    }else
       {
            return 0
        }

    }
    //header view delegate method:
    
    func didSelectUserHeaderTableViewCell(Selected: Bool, UserHeader: HeaderTableViewCell) {
        print("Cell Selected! \(UserHeader.sectionNumber) \(UserHeader.cityId)");
       
        //vaghti heaer ra entekhab kard,ba asase section num mre be safe moshahede hame
     
        
        //  let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "selectHeaderVC") as? selectHeaderVC
        print(UserHeader.sectionNumber)
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFade
        // self.navigationController?.view.layer.add(transition, forKey: nil)
       // self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
        //applySearchFilters()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == subListTableView {
        //che safe e?
        
        }
    }
    
    //collection view selection delegate:
    func goToDetailFromHome(itemIndex: Int,secttion:Int) {
        print("\(itemIndex)--\(secttion)")
        let arr = [0,0,0,1,1,2]
        print("\(itemIndex + 5)--\(arr[secttion])")
        let getMusic = GetMusicFromVitrin()
        getMusic.id = "\(itemIndex + 5)"
        getMusic.refferer_id = "\(arr[secttion])"
        netObject.getMusicDataFromVitrin(getMusicVitrinObject: getMusic)
        activity.startAnimating()
      //  (vitrinData.vitrins?[secttion])[itemIndex].
      //  let p1 = vitrinData.vitrins[section]
        
       // print((vitrinData.vitrins[section]).items[itemIndex].id)
        //navigate
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == homePageTableView
        {
         if indexPath.section == 0 {
         return 200
         }else if indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 5
         {
            return 130
         }else
         {
            return 130
            
         }
        
         }else{
            if indexPath.section == 0 {
            
             return 150
            }else{
         return 70
            }
         
    }
    
    }
    //networkDelegate
    func getVitrinDataResponse(res: vitrinResponse) {
        if res.message == "Operation was succsessful." {
       
            vitrinData = res
            vitrinContent = res
         
            print(vitrinData.banners?.count)
            homePageTableView.dataSource = self            
            homePageTableView.delegate = self
            homePageTableView.reloadData()
            
           // let cell  = homePageTableView.cellForRow(at: [0,0]) as! VitrinCell
            //cell.MusicCollectionView.reloadData()
//            cell.vitrinContent = vitrinData
//            homePageTableView.reloadData()
        }else{
        
            
        //netWork problem!
        
        }
    }
    
    func getMusicFromVitrinDataResponse(res : GetMusicFromVitrinResponse){
    
        activity.stopAnimating()
        let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        playItem = res
        self.navigationController?.pushViewController(vc, animated: true)
    
    
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
    //music pannel at home page:
    @IBOutlet weak var nameOfItem: UILabel!
    
    @IBAction func previousItem(_ sender: Any) {
    }
    @IBAction func playOrPauseItem(_ sender: Any) {
    }
    @IBAction func nextItem(_ sender: Any) {
    }

    @IBAction func closeButton(_ sender: Any) {
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
}

