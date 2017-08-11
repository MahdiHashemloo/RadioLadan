//
//  NewCommentController.swift
//  RadioLadan
//
//  Created by Apple on 6/4/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit

class NewCommentController: UIViewController,CommentPr {

    var item_id = ""
    @IBOutlet weak var newMessageTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        netObject.commentDelegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtn(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func sendNewMessageBtn(_ sender: Any) {
        let sendNewComment = SetComment()
        
        sendNewComment.user_id = shared_User_Id
        sendNewComment.item_id = item_id
        sendNewComment.comment = newMessageTextView.text!
        netObject.setComment(object: sendNewComment)
        
    }
    
    
    func setCommentForItem(success: Bool) {
        if success {
        alert2(msg: "نظر شما با موفقیت ثبت شد.")
             _ = navigationController?.popViewController(animated: true)
        }else{
        alert2(msg: "خطا در ارتباط")
        
        }
        
    }
    
    func getCommentForItem(object: GetComment, success: Bool) {
        
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
