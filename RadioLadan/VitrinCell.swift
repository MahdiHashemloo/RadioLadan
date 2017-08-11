//
//  VitrinCell.swift
//  RadioLadan
//
//  Created by Apple on 4/25/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit
//import ImageSlideshow
import Kingfisher

protocol HomeTODetail {
    func goToDetailFromHome(itemIndex:Int,secttion:Int)
}

class VitrinCell: UITableViewCell ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,iCarouselDataSource, iCarouselDelegate{
    //carose;
    
    @IBOutlet weak var carousel: iCarousel!
    
    //imagePagerCell
    
//    @IBOutlet weak var imagePager: ImageSlideshow!
    var items: [Int] = []
    var pageImages : NSArray!
    
//    var imgArr = [InputSource]()
    //----------
    //imageCell:
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageBetweenCells: UIImageView!
    //-----------
    //music vitrinCells
    @IBOutlet weak var MusicCollectionView: UICollectionView!
    var vitrinObject = vitrin()
     var HomeTODetailDelegate : HomeTODetail?
    var sectionNum = 0
    var sectionIndex = 0
    
    @IBOutlet weak var separatorView: UIView!
    //-------------
    override func awakeFromNib() {
        super.awakeFromNib()
        if let c = carousel {
        
            carousel!.type = .linear
            self.carousel?.delegate = self
            self.carousel?.dataSource = self
           // carousel.isDragging = false
            carousel.isPagingEnabled = true
            carousel.isScrollEnabled = true
            
          //  carousel.isDragging = false
            Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
        
        }
       
        
        if reuseIdentifier == "VitrinCell"{
        
//            imagePager.backgroundColor = UIColor.clear
//            imagePager.slideshowInterval = 5.0
//            imagePager.pageControlPosition = PageControlPosition.insideScrollView
//            imagePager.pageControl.currentPageIndicatorTintColor = UIColor.white;
//            imagePager.pageControl.pageIndicatorTintColor = UIColor.darkGray;
//            imagePager.contentScaleMode = UIViewContentMode.scaleToFill
//            
//
//            
//            if(vitrinContent.banners?.count != 0 ){
//                for i in (vitrinContent.banners)! {
//                    //    urlStringTemp.append(i.fileName!)
//                    let urlImg = i.image!
//      
//                    let img = KingfisherSource(urlString:urlImg)!
//      
//                    print(urlImg)
//                    imgArr.append(img)
//                }
//            }
//            
//           
//            
//                imagePager.setImageInputs(imgArr)
//            
//            
//            
//            let recognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap(recognizer:)))
//            
//            
//            recognizer.delegate = self
//            imagePager.addGestureRecognizer(recognizer)
        
        }else if reuseIdentifier == "vitrinCollectionCell" {
        
            MusicCollectionView.dataSource = self
            MusicCollectionView.delegate = self
           // MusicCollectionView.reloadData()
            
        
        }else if reuseIdentifier == "" {
        
        
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (vitrinObject.items?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // return CGSize(width: self.frame.size.width * 0.6, height: self.frame.size.width * 0.5)
        return CGSize(width: 115, height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! CollectionViewCell
        let str = vitrinObject.items?[indexPath.item].image
        cell.albumImage.kf.setImage(with: URL(string: str!))
        cell.albumLabel.text = (vitrinObject.items?[indexPath.item].title)!
        //  cell.transform = CGAffineTransform(scaleX: -1 , y: 1)
        
        
        // cell.transform = CGAffineTransform(scaleX: -1 , y: 1)
        
        ///Image/1701301250261800.jpg
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.HomeTODetailDelegate?.goToDetailFromHome(itemIndex:indexPath.item,secttion:sectionIndex)
        
        
    }
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        //goToImagePageDelegate?.goToImagePageDetail()
    }
    //carousel
    var items2: [Int] = []
    var pageImages2 : NSArray!
    let back_color = UIColor(red: 22/255, green: 26/255, blue: 60/255, alpha: 1)
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView
    {
        let imagView3 = UIImageView(frame:CGRect(x: 0, y: 5, width: 50, height: 35))
        
        let imagView2 = UIImageView(frame:CGRect(x: self.frame.size.width - 165, y: 20,width: 75, height: 75 ))
        let backView = UIView(frame: CGRect(x: 10 , y: 0, width: self.frame.size.width * 0.7, height: self.frame.size.height * 0.8))
        backView.backgroundColor = back_color
        backView.layer.cornerRadius = 10
        imagView2.cornerRadius = 10
        
        imagView3.contentMode = .scaleAspectFit
        imagView3.clipsToBounds = true
        var label: UILabel
        var itemView: UIImageView
        
        //create new view if no view is available for recycling
        if (view == nil)
        {
            //don't do anything specific to the index within
            //this `if (view == nil) {...}` statement because the view will be
            
            //recycled and used with other index values later
            itemView = UIImageView(frame:CGRect(x: 20, y: 20, width: self.frame.size.width - 90, height: self.frame.size.height - 40))
            itemView.layer.cornerRadius = 20
            // itemView.image = UIImage(named: pageImages[index] as! String)
            //itemView.kf.setImage(with: URL(string: ("\(imageURLs[index])")))
            print("carousel\(bannerImageURLs[index])  \(index) \(bannerImageURLs.count)")
            let url = URL(string: bannerImageURLs[index])!
            // itemView.kf.setImage(with:url, placeholder: nil, options:[.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
           // itemView.image = #imageLiteral(resourceName: "shuffleIcon")
            itemView.backgroundColor = UIColor.clear
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
       // label.text = "\(items2[index])"
      //  itemView.addSubview(backView)
        imagView3.image = #imageLiteral(resourceName: "g-clef-musical-note")
        itemView.addSubview(backView)
        itemView.addSubview(imagView2)
        itemView.addSubview(imagView3)
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        if (option == .spacing)
        {
            return value * 1.05
        }
        if (option == .arc)
        {
            return value * 1.5
        }
        if (option == .radius)
        {
            return value * 2
        }
        return value
    }
    func numberOfItems(in carousel: iCarousel) -> Int {
        return bannerImageURLs.count
    }
    
    func updateTimer(_ timer: Timer) {
        //  int; index=carousel1.currentIndex
        // let index = carousel?.currentItemIndex
        //    carousel(carousel!, viewForItemAtIndex: index!, reusingView: <#T##UIView?#>)
        carousel?.scroll(byNumberOfItems: 1, duration: 1)
        /// print("gfgf")
    }

}
