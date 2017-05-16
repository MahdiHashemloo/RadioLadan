//
//  ValidationCodeController.swift
//  RadioLadan
//
//  Created by Apple on 4/25/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit

class ValidationCodeController: UIViewController ,validateCodePr{

    
    let netObject = NetworkManager()
    
    var numRegResponse = NumRegisterResponse()
    
    @IBOutlet weak var validationCode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        netObject.validateCodeDelegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func countinueButton(_ sender: Any) {
        let validateObj = ActivateCode()
        validateObj.user_id = numRegResponse.user_id
        validateObj.code = validationCode.text!
        netObject.validationCode(object: validateObj)
        
    }
    
    func validateCodeResponse(res: ActivateCodeResponse) {
        print(res.user_info!)
        let getInformationController = self.storyboard?.instantiateViewController(withIdentifier: "GetInformationController") as! GetInformationController
        navigationController?.pushViewController(getInformationController, animated: true)
        
    }

    @IBAction func changeNumberButton(_ sender: Any) {
       _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resendValidateCode(_ sender: Any) {
        
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
