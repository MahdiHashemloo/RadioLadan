//
//  ValidationCodeController.swift
//  RadioLadan
//
//  Created by Apple on 4/25/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit

class ValidationCodeController: UIViewController ,validateCodePr,numberReq{

    
    let netObject = NetworkManager()
    var phoneNumber = ""
    var numRegResponse = NumRegisterResponse()
    
    @IBOutlet weak var validationCode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        netObject.validateCodeDelegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
      //  self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func countinueButton(_ sender: Any) {
        validationCode.endEditing(true)
        let validateObj = ActivateCode()
        validateObj.user_id = numRegResponse.user_id
        validateObj.code = validationCode.text!
        netObject.validationCode(object: validateObj)
        
    }
    
    func validateCodeResponse(res: ActivateCodeResponse) {
      //  print(res.user_info!)
        print(res.code!)
        if res.code == "102"{
        
        alert2(msg: "کد اشتباه")
        } else if res.code! == "106" {
                print("\(res.user_id!)")
                defaults.set("\(res.user_id!)", forKey: "user_id")
                defaults.set(true, forKey: "isLogin")
                //ghablan sabte nam karde
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
                self.navigationController!.popToViewController(viewControllers[0], animated: false);
            }else if res.code! == "100" {
                //avalin bareshe
                let getInformationController = self.storyboard?.instantiateViewController(withIdentifier: "GetInformationController") as! GetInformationController
            getInformationController.userId = res.user_id!
                navigationController?.pushViewController(getInformationController, animated: true)
            }
            

        
        
        
    }

    @IBAction func changeNumberButton(_ sender: Any) {
       _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resendValidateCode(_ sender: Any) {
        let numObj = NumRegister()
        numObj.mobile = phoneNumber
        let deviceInfoObj = Device_info()
        deviceInfoObj.sui = UIDevice.current.identifierForVendor!.uuidString
        
        deviceInfoObj.model = UIDevice.current.name
        numObj.device_info?.append(deviceInfoObj)
        let validationCodeController = self.storyboard?.instantiateViewController(withIdentifier: "ValidationCodeController") as! ValidationCodeController
        validationCodeController.phoneNumber = numObj.mobile!
        
        
        netObject.numberReq(numObject: numObj)

    }
    
    
    
    func numberReqResponse(res: NumRegisterResponse) {
        //  if res.code == "100"{
        
        self.numRegResponse.user_id = res.user_id
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
