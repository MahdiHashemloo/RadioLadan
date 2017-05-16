//
//  VitrinCell.swift
//  RadioLadan
//
//  Created by Apple on 4/25/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit
import ImageSlideshow
import Kingfisher

protocol HomeTODetail {
    func goToDetailFromHome(itemIndex:Int,secttion:Int)
}

class VitrinCell: UITableViewCell ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    //imagePagerCell
    
    @IBOutlet weak var imagePager: ImageSlideshow!
    var items: [Int] = []
    var pageImages : NSArray!
    
    var imgArr = [InputSource]()
    //----------
    //imageCell:
    
    @IBOutlet weak var imageBetweenCells: UIImageView!
    //-----------
    //music vitrinCells
    @IBOutlet weak var MusicCollectionView: UICollectionView!
    var vitrinObject = vitrin()
     var HomeTODetailDelegate : HomeTODetail?
    var sectionNum = 0
    //-------------
    override func awakeFromNib() {
        super.awakeFromNib()
        if reuseIdentifier == "VitrinCell"{
        
            imagePager.backgroundColor = UIColor.clear
            imagePager.slideshowInterval = 5.0
            imagePager.pageControlPosition = PageControlPosition.insideScrollView
            imagePager.pageControl.currentPageIndicatorTintColor = UIColor.white;
            imagePager.pageControl.pageIndicatorTintColor = UIColor.darkGray;
            imagePager.contentScaleMode = UIViewContentMode.scaleToFill
            
            print(vitrinContent.banners?.count)
            
            if(vitrinContent.banners?.count != 0 ){
                for i in (vitrinContent.banners)! {
                    //    urlStringTemp.append(i.fileName!)
                    let urlImg = i.image!
                    
                   // let str = urlImg.insert(string: "_small", ind: (urlImg.characters.count - 4))
                    let img = KingfisherSource(urlString:urlImg)!
                  //  var kingfisherSource = KingfisherSource(urlString: "")! as! KingfisherSource
                    print(urlImg)
                    imgArr.append(img)
                }
            }
            
           
            
                imagePager.setImageInputs(imgArr)
            
            
            
            let recognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap(recognizer:)))
            
            
            recognizer.delegate = self
            imagePager.addGestureRecognizer(recognizer)
        
        }else if reuseIdentifier == "vitrinCollectionCell" {
        
            MusicCollectionView.dataSource = self
            MusicCollectionView.delegate = self
           // MusicCollectionView.reloadData()
            
        
        }else if reuseIdentifier == "" {
        
        
        }
//        MusicCollectionView.delegate = self
//        MusicCollectionView.dataSource = self
        // Initialization code
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
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
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
        // print(indexPath.section)
        //   print(indexPath.item)
        
        //  print(tableSectionNumber)
        //  print((mainResponse[tableSectionNumber!].placeList[indexPath.item].id)!)
        //    idForDetailPage = (mainResponse[tableSectionNumber!].placeList[indexPath.item].id)!
        self.HomeTODetailDelegate?.goToDetailFromHome(itemIndex:indexPath.item,secttion:sectionNum)
        
        
    }
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        //goToImagePageDelegate?.goToImagePageDetail()
    }
}
