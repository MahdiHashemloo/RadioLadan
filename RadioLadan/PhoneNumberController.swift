//
//  PhoneNumberController.swift
//  RadioLadan
//
//  Created by Apple on 4/25/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit

class PhoneNumberController: UIViewController,UITextFieldDelegate,numberReq {
    @IBOutlet weak var numberTxtField: UITextField!

    let netObject = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        netObject.numberReqDelegate = self
        numberTxtField.delegate = self
        let uiDevice = UIDevice.current.name
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        print(uuid)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       // self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func countinueButton(_ sender: Any) {
        if numberTxtField.text?.characters.count == 11 {
        
            let numObj = NumRegister()
            numObj.mobile = numberTxtField.text!
            let deviceInfoObj = Device_info()
            deviceInfoObj.sui = UIDevice.current.identifierForVendor!.uuidString
            
            deviceInfoObj.model = UIDevice.current.name
            numObj.device_info?.append(deviceInfoObj)
             let validationCodeController = self.storyboard?.instantiateViewController(withIdentifier: "ValidationCodeController") as! ValidationCodeController
            validationCodeController.phoneNumber = numObj.mobile!
            
            
            netObject.numberReq(numObject: numObj)
            numberTxtField.endEditing(true)

        }else{
        alert2(msg:"شماره تلفن اشتباه")
        
        }
          }
    
    func numberReqResponse(res: NumRegisterResponse) {
      //  if res.code == "100"{
        
           
            
            let validationCodeController = self.storyboard?.instantiateViewController(withIdentifier: "ValidationCodeController") as! ValidationCodeController
            validationCodeController.numRegResponse.user_id = res.user_id
            navigationController?.pushViewController(validationCodeController, animated: true)
         
        
       // }
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text?.characters.count)! < 12 {
        return true
        }else{return false  }
    }
    
    
    
 
    @IBAction func backBtn(_ sender: Any) {
        
        _ = navigationController?.popViewController(animated: true)
        
        
    }

    @IBAction func backButton(_ sender: Any) {
           _ = navigationController?.popViewController(animated: true)
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
