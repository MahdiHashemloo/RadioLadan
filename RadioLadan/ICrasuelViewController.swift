//
//  ICrasuelViewController.swift
//  TakNegar4
//
//  Created by nazanin hashemloo on ۱۳۹۵/۷/۱۷ ه‍.ش..
//  Copyright © ۱۳۹۵ ه‍.ش. Mahdi hashemloo. All rights reserved.
//

import UIKit
import Kingfisher

var bannerImageURLs = [""]
var imageURLs = [""]


class ICrasuelViewController: UIViewController , iCarouselDataSource, iCarouselDelegate  ,getVitrinDataPr{
    var items: [Int] = []
    var pageImages : NSArray!
    
   // var images = []
    @IBOutlet var carousel : iCarousel?
    
    
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        for i in 0...99
        {
            items.append(i)
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

                self.pageImages = NSArray(objects: "1","2","author")
//        var imgTemp = [UIImageView]()
//        for i in imageURLs {
//            let imageView = UIImageView()
//          let img = imageView.kf.setImage(with: URL(string: ("\(i)")))
//        
//        imgTemp.append(img)
//        
//        }
        netObject.getVitrinDataDelegate = self
        let obj = GetVitrin()
        netObject.getVitrinData(getVitrinObject: obj)
        
        
     
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
      
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
    }

    func getVitrinDataResponse(res: vitrinResponse) {
        vitrinContent = res
        var temp = [String]()
        for i in vitrinContent.banners! {
            temp.append(i.image!)
            
        }
        bannerImageURLs = temp
        
        carousel!.type = .rotary
        self.carousel?.delegate = self
        self.carousel?.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
     
    }
    var i = 0
    func updateTimer(_ timer: Timer) {
        //  int; index=carousel1.currentIndex
        // let index = carousel?.currentItemIndex
        //    carousel(carousel!, viewForItemAtIndex: index!, reusingView: <#T##UIView?#>)
        carousel?.scroll(byNumberOfItems: 1, duration: 1)
        /// print("gfgf")
    }

    //======
    
    func numberOfItems(in carousel: iCarousel) -> Int
    {
        return bannerImageURLs.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView
    {
         let imagView2 = UIImageView(frame:CGRect(x: self.view.frame.size.width / 2, y: 20, width: self.view.frame.size.width * 0.25, height: self.view.frame.size.height - 40))
        let backView = UIView(frame: CGRect(x: self.view.frame.size.width / 2, y: 20, width: self.view.frame.size.width * 0.25, height: self.view.frame.size.height - 40))
        backView.backgroundColor = UIColor.lightGray
        var label: UILabel
        var itemView: UIImageView
        
        //create new view if no view is available for recycling
        if (view == nil)
        {
            //don't do anything specific to the index within
            //this `if (view == nil) {...}` statement because the view will be
           
            //recycled and used with other index values later
            itemView = UIImageView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
            
           // itemView.image = UIImage(named: pageImages[index] as! String)
            //itemView.kf.setImage(with: URL(string: ("\(bannerImageURLs[index])")))
            print(bannerImageURLs[index])
            let url = URL(string: bannerImageURLs[index])!
           // itemView.kf.setImage(with:url, placeholder: nil, options:[.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
            itemView.image = #imageLiteral(resourceName: "shuffleIcon")
            //itemView.addSubview(<#T##view: UIView##UIView#>)
            imagView2.kf.setImage(with:url, placeholder: nil, options:[.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
            itemView.contentMode = .redraw
            itemView.addSubview(imagView2)
            label = UILabel(frame:itemView.bounds)
            label.backgroundColor = UIColor.clear
            label.textAlignment = .center
            label.font = label.font.withSize(50)
            label.tag = 1
            // itemView.addSubview(label)
        }
        else
        {
            //get a reference to the label in the recycled view
            itemView = view as! UIImageView;
            
            label = itemView.viewWithTag(1) as! UILabel!
        }
        
        //set item label
        //remember to always set any properties of your carousel item
        //views outside of the `if (view == nil) {...}` check otherwise
        //you'll get weird issues with carousel item content appearing
        //in the wrong place in the carousel
        label.text = "\(items[index])"
        
        itemView.addSubview(imagView2)
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        if (option == .spacing)
        {
            return value * 1.2
        }
        if (option == .arc)
        {
            return value * 0.9
        }
        if (option == .radius)
        {
            return value * 0.7
        }
        return value
    }
    
    func getSublistData(res: GetSublistresponse) {
        
    }
    
    func getMusicFromVitrinDataResponse(res: GetMusicFromVitrinResponse) {
        
    }
}
