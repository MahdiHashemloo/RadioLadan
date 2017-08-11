//
//  ProfileController.swift
//  RadioLadan
//
//  Created by Apple on 5/21/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit
import MobileCoreServices

class ProfileController: UIViewController,ProfilePr , UICollectionViewDataSource,UINavigationControllerDelegate, UICollectionViewDelegate,UIImagePickerControllerDelegate,CompleteInfoPr{

    let setProfile = SetProfile()
    
    @IBOutlet weak var sentItemsView: UIView!
    
    @IBOutlet weak var sendItemCollectionView: UICollectionView!
    
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var prifileName: UILabel!
    
    @IBOutlet weak var profilaEmail: UILabel!
    
    @IBOutlet weak var alagheMandiHaImageView: UIImageView!
    
    @IBOutlet weak var mavaredeErsalShodeImageView: UIImageView!
    
    @IBOutlet weak var mavareErsalCountLabel: UILabel!
    
    @IBOutlet weak var alagheMandiCountLabel: UILabel!
    @IBOutlet weak var likedView: UIView!
    @IBOutlet weak var likedCollectionView: UICollectionView!
    
    //edit profile:
    
    var isEditingMode = false
    
    @IBOutlet weak var editNameField: UITextField!
    
    @IBOutlet weak var editProfileButton: UIButton!
    
    @IBOutlet weak var editImageBtn: UIButton!
    @IBOutlet weak var edidtMailField: UITextField!
    @IBOutlet weak var saveChangesButton: UIButton!
    
    @IBOutlet weak var cancelChangesButton: UIButton!
    //change image
    var imgArr = ["",""]
    var uploadedImageId = 0
    //var uploadeImageObj : image?
    var newMedia: Bool?
    var clearImageFile = false
    var strBase64:String?
    var saved = false
    var imageChanged = false
    
    ///
    
    
    
    ///
    let netObj = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        netObject.CompleteInfoDelegate = self
       
            // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = true
        
        editImageBtn.alpha = 0
        prifileName.alpha = 1
        profilaEmail.alpha = 1
        editNameField.alpha = 0
        edidtMailField.alpha = 0
        saveChangesButton.alpha = 0
        cancelChangesButton.alpha = 0
        logOutBtn.alpha = 1
        backBtn.alpha = 1
        editProfileButton.alpha = 1
        editImageBtn.alpha = 0
        likedView.isHidden = false
        sentItemsView.isHidden = true

    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        netObj.getProfileDelegate = self
        let profileTemp = GetProfile()
        let id = defaults.value(forKey: "user_id")
        print("id\(id)")
        profileTemp.user_id = shared_User_Id
        netObj.getProfileUser(object: profileTemp)
       prifileName.text = profileObj.fname! + " " + profileObj.lname!

        
        if let faveCount = profileObj.fave?.count {
         alagheMandiCountLabel.text = "\(faveCount)"
        
        }
        profilaEmail.text = profileObj.email!
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func alagheMandiAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.likedView.isHidden = false
            self.sentItemsView.isHidden = true
            self.alagheMandiHaImageView.alpha = 1
            self.mavaredeErsalShodeImageView.alpha = 0
            self.likedCollectionView.alpha = 1
            self.sendItemCollectionView.alpha = 0
            
            self.view.layoutIfNeeded()
        }, completion: nil)

 
        
        
    }
    
    
    @IBAction func mavaredeErsalShodeAction(_ sender: Any) {
      
        
        
           
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.likedView.isHidden = true
                self.sentItemsView.isHidden = false
                self.alagheMandiHaImageView.alpha = 0
                self.mavaredeErsalShodeImageView.alpha = 1
                self.likedCollectionView.alpha = 0
                self.sendItemCollectionView.alpha = 1
                self.view.layoutIfNeeded()
            }, completion: nil)

 
        
    }
    @IBAction func sendLabelAction(_ sender: Any) {
        
        
    }
    @IBAction func likedLabelAction(_ sender: Any) {
        
        
    }
    
    //Mark: - DelegateMethods
    func getProfileResponse(res: GetProfileResponse) {
        print("res.fname : \(res.fname)")
        profileObj = res
        prifileName.text = res.fname! + "" + res.lname!
        profilaEmail.text = res.email!
        if let ava = res.avatar {
        
        profileImageView.kf.setImage(with: URL(string: res.avatar!))
        
        }else{
        
        profileImageView.image = #imageLiteral(resourceName: "profile.png")
        }
        
        likedCollectionView.delegate = self
        likedCollectionView.dataSource = self
        likedCollectionView.reloadData()
        
    }
      // MARK: - Collection view methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let c = profileObj.fave?.count {
        return c
        }else{return 2}
       // return (profileObj.fave?.count)!
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        
  
        if let img = profileObj.fave?[indexPath.item].image {
        
            cell.itemImageView.kf.setImage(with: URL(string: (img)))
            
            cell.itemTitleLabel.text = (profileObj.fave?[indexPath.item].title)!

        
        }
        print(profileObj.fave?[indexPath.item].image)
               return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // return CGSize(width: self.frame.size.width * 0.6, height: self.frame.size.width * 0.5)
        return CGSize(width: 50, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    @IBAction func backBtn(_ sender: Any) {
       //  self.navigationController?.isNavigationBarHidden = false
       _ =  navigationController?.popViewController(animated: true)
    }
    
    // MARK - editActions
    
    
    @IBAction func gotoEditMode(_ sender: Any) {
       gotoTheEditMode()
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        
        defaults.set("-1", forKey: "user_id")
        defaults.set(false, forKey: "isLogin")
        _  = navigationController?.popViewController(animated: true)
        
    }
    
    func gotoTheEditMode() {
        if isEditingMode {
            
            editImageBtn.alpha = 0
            prifileName.alpha = 1
            profilaEmail.alpha = 1
            editNameField.alpha = 0
            edidtMailField.alpha = 0
            saveChangesButton.alpha = 0
            cancelChangesButton.alpha = 0
            logOutBtn.alpha = 1
            backBtn.alpha = 1
            editProfileButton.alpha = 1
        editImageBtn.alpha = 0
            isEditingMode  = false
           
             self.view.endEditing(true)
            //hide keyboard
        }else{
            editImageBtn.alpha = 1
            prifileName.alpha = 0
            profilaEmail.alpha = 0
            editNameField.alpha = 1
            edidtMailField.alpha = 1
            saveChangesButton.alpha = 1
            cancelChangesButton.alpha = 1
            logOutBtn.alpha = 0
            backBtn.alpha = 0
             editProfileButton.alpha = 0
            editImageBtn.alpha = 1
            editNameField.text =  profileObj.fname! + " " + profileObj.lname!
            edidtMailField.text =  profileObj.email!
            isEditingMode  = true
           editNameField.becomeFirstResponder()
           
        }
    }
    @IBAction func setImage(_ sender: Any) {
        changeImage()
    }
    
    @IBAction func saveChangesAction(_ sender: Any) {
        //1)sendData
        setProfile.fname = editNameField.text!
        setProfile.email = edidtMailField.text!
        setProfile.user_id = shared_User_Id
        netObject.completeInformationCode(object: setProfile)
        //2)show indicator
        gotoTheEditMode()
    }
    
    
    
    @IBAction func cancelChangesAction(_ sender: Any) {
        gotoTheEditMode()
    }
    
    //MARK: - CAMERA METHODS:
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(to:kUTTypeImage as String) {
            let image = info[UIImagePickerControllerEditedImage]
                as! UIImage
            
            //  imageView.image = image
            //  let myPicture = UIImage(data: try! Data(contentsOf: URL(string:"http://i.stack.imgur.com/Xs4RX.jpg")!))!
            let newImg = resizeImage(image: image, newWidth: 50)
           // let myThumb1 = image.resized(withPercentage: 0.1)
           // let myThumb2 = image.resized(toWidth: 72.0)
        
            
            let imageData:NSData = UIImagePNGRepresentation(newImg)! as NSData
            strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            print(strBase64)
            profileImageView.image = image
            setProfile.avatar = strBase64!
            //hala base 64 ro upload mikonim va url ro az server migirim
           // netObject.uploadImg(base64: strBase64!)
            setProfile.fname = editNameField.text!
            setProfile.email = edidtMailField.text!
            setProfile.user_id = shared_User_Id
            netObject.completeInformationCode(object: setProfile)
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                                               #selector(ProfileController.image(image:didFinishSavingWithError:contextInfo:)), nil)
            } else if mediaType.isEqual(to: kUTTypeMovie as String) {
                // Code to support video here
            }
            
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafeRawPointer) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                                          message: "Failed to save image",
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true,
                         completion: nil)
        }
    }
    
    
    func changeImage() {
        let myAttribute = [ NSFontAttributeName: UIFont(name: "IRANSansFaNum-Light", size: 18.0)! ]
        let myAttribute2 = [ NSFontAttributeName: UIFont(name: "IRANSansFaNum-Light", size: 14)! ]
        let myAttrString = NSAttributedString(string: "رادیو لادن", attributes: myAttribute)
        let attrMessage = NSAttributedString(string: "ویرایش عکس پروفایل", attributes: myAttribute2)
        let refreshAlert = UIAlertController(title: "Refresh", message: "لبای ستس تس ست", preferredStyle: UIAlertControllerStyle.actionSheet)
        refreshAlert.setValue(myAttrString, forKey: "attributedTitle")
        refreshAlert.setValue(attrMessage, forKey: "attributedMessage")
        
        refreshAlert.addAction(UIAlertAction(title: "دوربین", style: .default, handler: { (action: UIAlertAction!) in
            
            
            if UIImagePickerController.isSourceTypeAvailable(
                UIImagePickerControllerSourceType.camera) {
                
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.camera
                imagePicker.mediaTypes = [kUTTypeImage as String]
                imagePicker.allowsEditing = true
                
                self.present(imagePicker, animated: true,
                             completion: nil)
                self.newMedia = true
            }
            
            self.imageChanged = true
            print("Handle Ok logic here")
        }))
        let action = UIAlertAction(title: "گالری", style: .default, handler: { (action: UIAlertAction!) in
            
            
            if UIImagePickerController.isSourceTypeAvailable(
                UIImagePickerControllerSourceType.savedPhotosAlbum) {
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.photoLibrary
                imagePicker.mediaTypes = [kUTTypeImage as String]
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true,
                             completion: nil)
                self.newMedia = false
            }
            
            self.imageChanged = true
            
        })
        
        
        refreshAlert.addAction(action)
        
        let cancelaction = UIAlertAction(title: "لغو", style: .cancel, handler: { (action: UIAlertAction!) in
            
            
            
            
            
            print("Handle Cancel Logic here")
        })
        
        let clearImage = UIAlertAction(title: "حذف عکس", style: .default, handler: { (action: UIAlertAction!) in
 //           self.clearImageFile = true
            
//            customerDetail?.image = nil
//            customerDetail?.imageId = nil
//            self.editProfileTableView.reloadData()
        self.setProfile.avatar = ""
            self.profileImageView.image = nil
            
            //senddata
            print("Handle delete image Logic here")
        })
        
        
        refreshAlert.addAction(cancelaction)
        refreshAlert.addAction(clearImage)
        present(refreshAlert, animated: true, completion: nil)
        
        
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //MARK: - COMPELETE INFORMATION
    func CompleteInfoResponse(res: CompleteInformationResponse) {
        
        let profileTemp = GetProfile()
        let id = defaults.value(forKey: "user_id")
        print("id\(id)")
        profileTemp.user_id = shared_User_Id
        netObj.getProfileUser(object: profileTemp)
        
    }

    @IBAction func SendVoiceFile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RecorderController") as! RecorderController
        
        navigationController?.pushViewController(vc, animated: true)
        
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
