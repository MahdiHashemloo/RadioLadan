//
//  CatListItemController.swift
//  RadioLadan
//
//  Created by Apple on 5/12/17.
//  Copyright © 2017 MHDY. All rights reserved.
//  "IRANSansFaNum-Light"
//
import UIKit
import Segmentio
class CatListItemController: UIViewController {
    @IBOutlet weak var segmentIoView: Segmentio!

    var font = UIFont()
    override func viewDidLoad() {
        super.viewDidLoad()
listFonts()
       font = UIFont(name: "IRANSansFaNum-Light", size: 15)!
        segmentIoImplementation()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
       // let font = UIFont(name: "", size: <#T##CGFloat#>)
        //  let font = UIFont(name: "IRANSans(FaNum)_Light", size: 15)
        
        
        content.append(tornadoItem1)
        content.append(tornadoItem2)
        content.append(tornadoItem3)
        self.segmentIoView.setup(content: content, style: SegmentioStyle.imageOverLabel, options:SegmentioOptions(backgroundColor: .clear, maxVisibleItems: 3, scrollEnabled: true, indicatorOptions: SegmentioIndicatorOptions.init(type: .bottom, ratio: 0.5, height: 2, color: .blue), horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions.init(type: .bottom, height: 1, color: .clear), verticalSeparatorOptions: SegmentioVerticalSeparatorOptions.init(ratio: 1, color: .clear), imageContentMode: .center, labelTextAlignment: .center, labelTextNumberOfLines: 1, segmentStates: SegmentioStates(
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


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
