//
//  NetworkManager.swift
//  RadioLadan
//
//  Created by Apple on 4/25/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
//MARK:register number
protocol numberReq {
    func numberReqResponse(res : NumRegisterResponse)
}

protocol validateCodePr {
    func validateCodeResponse(res : ActivateCodeResponse)
}

protocol CompleteInfoPr {
    func CompleteInfoResponse(res : CompleteInformationResponse)
}

protocol getVitrinDataPr {
    func getVitrinDataResponse(res : vitrinResponse)
    func getMusicFromVitrinDataResponse(res : GetMusicFromVitrinResponse)
    func getSublistData(res : GetSublistresponse)
    
}
class NetworkManager: NSObject {
    
    var numberReqDelegate : numberReq?
    var validateCodeDelegate : validateCodePr?
    var CompleteInfoDelegate : CompleteInfoPr?
    var getVitrinDataDelegate : getVitrinDataPr?
    
    var sessionManager = SessionManager()
    
    func numberReq(numObject : NumRegister) {

        Alamofire.request(mainUrl, method: .post, parameters: numObject.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<NumRegisterResponse>) in
                if let JSON = response.result.value
                {
                    
                    print("JSON: \(JSON)")
                }
                if response.result.isSuccess {
                
                    self.numberReqDelegate?.numberReqResponse(res: response.result.value!)
                
                }else{
                
                }
                
        }
           }
    
    
    func validationCode(object : ActivateCode) {
       
        Alamofire.request(mainUrl, method: .post, parameters: object.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<ActivateCodeResponse>) in
                if let JSON = response.result.value
                {
                    
                    print("JSON: \(JSON)")
                }
                if response.result.isSuccess {
                    
                    self.validateCodeDelegate?.validateCodeResponse(res: response.result.value!)
                    
                }else{
                    
                }
                
        }
    }
    
    //{"type":"set_profile","user_id":"1","fname":"حمیدرضا","lname":"صفی پور","email":"shaltoook@gmail.com","mobile":"09124153184"}
    func completeInformationCode(object : SetProfile) {
        
        Alamofire.request(mainUrl, method: .post, parameters: object.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<CompleteInformationResponse>) in
                if let JSON = response.result.value
                {
                    
                    print("JSON: \(JSON)")
                }
                if response.result.isSuccess {
                    
                    self.CompleteInfoDelegate?.CompleteInfoResponse(res: response.result.value!)
                    
                }else{
                    
                }
                
        }
    }
    
    
    
    func getVitrinData(getVitrinObject : GetVitrin) {
        
        Alamofire.request(mainUrl, method: .post, parameters: getVitrinObject.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<vitrinResponse>) in
                if let JSON = response.result.value
                {
                    
                    print("JSON: \(JSON)")
                }
                if response.result.isSuccess {
                    
                    self.getVitrinDataDelegate?.getVitrinDataResponse(res: response.result.value!)
                    
                }else{
                    
                }
                
        }
    }
    
    func getMusicDataFromVitrin(getMusicVitrinObject : GetMusicFromVitrin) {
        
        Alamofire.request(mainUrl, method: .post, parameters: getMusicVitrinObject.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<GetMusicFromVitrinResponse>) in
                if let JSON = response.result.value
                {
                    
                    print("JSON: \(JSON)")
                }
                if response.result.isSuccess {
                    
                    self.getVitrinDataDelegate?.getMusicFromVitrinDataResponse(res: response.result.value!)
                    
                }else{
                    
                }
                
        }
    }

    
    func getSublistItems(getSubListObject : GetSublist) {
        
        Alamofire.request(mainUrl, method: .post, parameters: getSubListObject.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<GetSublistresponse>) in
                if let JSON = response.result.value
                {
                    
                    print("JSON: \(JSON)")
                }
                if response.result.isSuccess {
                    
                    self.getVitrinDataDelegate?.getSublistData(res: response.result.value!)
                    
                }else{
                    
                }
                
        }
    }

    func getProfileUser(object : GetProfile) {
        
        Alamofire.request(mainUrl, method: .post, parameters: object.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<GetSublistresponse>) in
                if let JSON = response.result.value
                {
                    
                    print("JSON: \(JSON)")
                }
                if response.result.isSuccess {
                    
                    self.getVitrinDataDelegate?.getSublistData(res: response.result.value!)
                    
                }else{
                    
                }
                
        }
    }
    
    func uploadMusic() {
        let fileURL = Bundle.main.url(forResource: "akhar", withExtension: "mp3")
        
        Alamofire.upload(fileURL!, to: "http://ihamsane.ir/post")
            .uploadProgress { progress in // main queue by default
                print("Upload Progress: \(progress.fractionCompleted)")
            }
            .downloadProgress { progress in // main queue by default
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseJSON { response in
                debugPrint(response)
        }
    }
    

    func upload2() {
        let parameters = [
            "token": "08bec09645dd673d5adecdc72b481283"
        ,"user_id":"14"]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            let fileURL = Bundle.main.url(forResource: "akhar", withExtension: "mp3")
            multipartFormData.append(fileURL!, withName: "akhar", fileName: "akhar.mp3", mimeType: "akhar/mp3")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to:"http://ihamsane.ir")
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                     print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    //print response.result
                     debugPrint(response)
                }
                
            case .failure(let encodingError): break
                //print encodingError.description
                print(encodingError)
            }
        }
    }

}
/*{"type":"register","mobile":"09337771221","device_info":[{"os":"ios","model":"g3","sim":"0","sui":"6172fghjk4297","resolution":"","app_version":"1.0"}]}
 
 {"user_id":"14","code":"201"}
 
 //---
 {"type":"active_code","user_id":"14","code":"94017"}
 T3BlcmF0aW9uIHdhcyBzdWNjc2Vzc2Z1bC4=
 
 08bec09645dd673d5adecdc72b481283
 -----
 
 
 */
