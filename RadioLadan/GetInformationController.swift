//
//  GetInformationController.swift
//  RadioLadan
//
//  Created by Apple on 4/25/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit

class GetInformationController: UIViewController,CompleteInfoPr {
    var setProfileObj = SetProfile()
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lnameField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    
    let netObject = NetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        netObject.CompleteInfoDelegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func CompleteInfoResponse(res: CompleteInformationResponse) {
        print(res.code)
        print(res.message)
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[0], animated: false);
        
    }
    
    @IBAction func countinueButton(_ sender: Any) {
        let setProfileObj = SetProfile()
        setProfileObj.fname = nameField.text!
        setProfileObj.lname = lnameField.text!
        setProfileObj.email = mailField.text!
        netObject.completeInformationCode(object: setProfileObj)
        
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
