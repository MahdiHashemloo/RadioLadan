//
//  CommentsViewController.swift
//  RadioLadan
//
//  Created by Apple on 6/4/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit
import Jukebox
import Kingfisher
class CommentsViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,CommentPr{
    
    var itemId = ""
    var commentData = GetComment() {
        didSet {
            commentsTableView.dataSource = self
            commentsTableView.delegate = self
            if let count = commentData.comments?.count {
                commentsTableView.reloadData()
            }
 
            
        }
    }
    

    @IBOutlet weak var commentsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        netObject.commentDelegate = self
       

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

    
    override func viewWillAppear(_ animated: Bool) {
        hidePlayPannel()
        let commentObj = GetComment()
        commentObj.item_id = itemId
        commentObj.user_id = "\(shared_User_Id)"
        commentObj.section = "content"
        netObject.getComment(object: commentObj)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let c = commentData.comments?.count {
        return (commentData.comments?.count)!
        }else{
        return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        if let avatar = commentData.comments?[indexPath.row].user_avatar {
        cell.commentImage.kf.setImage(with: URL(string: avatar))
        
        }
        if let name = commentData.comments?[indexPath.row].user_fullname {
        cell.commentName.text = name
        }
        
        if let value = commentData.comments?[indexPath.row].content {
            cell.commentValue.text = value
        }
        
        
        
        return cell
    }
    

    @IBAction func createNewComment(_ sender: Any) {
        let newComment = storyboard?.instantiateViewController(withIdentifier: "NewCommentController") as! NewCommentController
        
        newComment.item_id = itemId
        
        navigationController?.pushViewController(newComment, animated: true)
        
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        
     //   _ = navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: comments delegates:
    func setCommentForItem(success: Bool) {
        
    }
    
    func getCommentForItem(object: GetComment, success: Bool) {
        if success{
            commentData = object
            
        }else{
            
            alert2(msg: "error in connection..")
        }
        
        
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
