//
//  BaseViewController.swift
//  RadioLadan
//
//  Created by nazanin hashemloo on 5/11/1396 AP.
//  Copyright © 1396 AP MHDY. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var sublistTableView : UITableView?
    var blurView: UIView?
    var backButton : UIButton?
    
    var sublistSelectedIndex : Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton = UIButton()
        backButton?.frame = CGRect(x: 15, y: 15, width: 40, height: 40)
        backButton?.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        backButton?.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        backButton?.addTarget(self, action: #selector(backAction), for: UIControlEvents.touchUpInside)
        blurView = UIView()
        blurView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
//        blurView?.isHidden = true
        blurView?.alpha = 0
        
        sublistTableView = UITableView()
        sublistTableView?.separatorColor = UIColor.clear
        sublistTableView?.backgroundColor = UIColor.clear
        sublistTableView?.frame = CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height)
       // sublistTableView?.dataSource = self
       // sublistTableView?.delegate  = self
       // sublistTableView?.reloadData()
        ImplementBlurView()
        // Do any additional setup after loading the view.
    }
    
    func backAction()  {
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
//            self.blurView?.isHidden = true
                  self.blurView?.alpha = 0
            
             self.view.layoutIfNeeded()
        }, completion: nil)
        

        
    }
    
    func showBlurMenu() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
//            self.blurView?.isHidden = false
            self.blurView?.alpha = 1
            
             self.view.layoutIfNeeded()
        }, completion: nil)
        sublistTableView?.dataSource = self
        sublistTableView?.delegate  = self
        sublistTableView?.reloadData()
    }
    
    
    func ImplementBlurView()  {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = (blurView?.bounds)!
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView?.addSubview(blurEffectView)
        blurView?.addSubview(sublistTableView!)
        blurView?.addSubview(backButton!)
        self.view.addSubview(blurView!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (subListData.items?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
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

            return HeaderCell
        default:
            let itemCell = Bundle.main.loadNibNamed("SublistTableViewCell", owner: self, options: nil)?.last as!  SublistTableViewCell
            
            if let imgString = (subListData.items?[indexPath.row].image) {
                let img = UIImageView()
                img.kf.setImage(with:URL(string:imgString), placeholder: nil, options:[.transition(.fade(1))], progressBlock: nil, completionHandler: nil)

                itemCell.Icon.setImage(img.image, for: .normal)
                
                
                itemCell.label.text = subListData.items?[indexPath.row].title
                
                //  cell.itemLabel.highlightedTextColor = UIColor.blue
                
            }
            return itemCell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
