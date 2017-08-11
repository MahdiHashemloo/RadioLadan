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
import SystemConfiguration


protocol searchPr {
    func searchResponse(res:GetPlayListResponse)
    func searchError(success:Bool)
}

protocol AddFavoritePr {
    func addFavoriteRes(statusCode : String)
}



protocol CommentPr {
    func getCommentForItem(object:GetComment,success : Bool)
    func setCommentForItem(success:Bool)
}



protocol content_list_pr {
    func getContentlistRes(res : GetContentListResponse)
    func getContentlistResFailed(err:String)
    
}


protocol PlayListNetProtocol {
    func getPlayListItems(res : GetPlayListResponse,isSuccess : Bool)
    func addToPlayListRes(res : CompleteInformationResponse)
    func createNiewPlaylistResponse(res : Bool)
    func getMusicFromVitrinDataResponse(res : GetMusicFromVitrinResponse)
    
}
protocol ProfilePr {
    func getProfileResponse(res : GetProfileResponse)
}

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
    var getProfileDelegate : ProfilePr?
    var playListNetDelegate :PlayListNetProtocol?
    var sessionManager = SessionManager()
    var getContentListDelegate : content_list_pr?
    var addFavoriteDelegate : AddFavoritePr?
    var commentDelegate : CommentPr?
    var searchDelegate:searchPr?
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
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
                    
                    print("JSON: \(JSON.toJSON())")
                }
                if response.result.isSuccess {
                    
                    self.getVitrinDataDelegate?.getVitrinDataResponse(res: response.result.value!)
                    
                }else{
                    
                }
                
        }
    }
    
    func getMusicDataFromVitrin(getMusicVitrinObject : GetMusicFromVitrin) {
        
        print(mainUrl)
        print(getMusicVitrinObject.toJSON())
        
        Alamofire.request(mainUrl, method: .post, parameters: getMusicVitrinObject.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<GetMusicFromVitrinResponse>) in
                if let JSON = response.result.value
                {
                    
                    print("JSON: \(JSON)")
                }
                if response.result.isSuccess {
                    
                    self.getVitrinDataDelegate?.getMusicFromVitrinDataResponse(res: response.result.value!)
                    
                    self.playListNetDelegate?.getMusicFromVitrinDataResponse(res:  response.result.value!)
                    
                }else{
                    
                }
                
        }
    }
    
    func getMusicDetail(getMusicVitrinObject : GetMusicFromVitrin, completion: @escaping (_ result: GetMusicFromVitrinResponse)->()) {
        
        
        Alamofire.request(mainUrl, method: .post, parameters: getMusicVitrinObject.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<GetMusicFromVitrinResponse>) in
                if let JSON = response.result.value
                {
                    completion(response.result.value!)
                   // print("JSON: \(JSON)")
                }
                if response.result.isSuccess {
                    
                   
                    
                }else{
                    
                }
                
        }
    }

    
    func getSublistItems(getSubListObject : GetSublist) {
        print(getSubListObject.toJSON())
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
                if response.result.isFailure{
                print(response.result.error)
                }
        }
    }

    func getProfileUser(object : GetProfile) {
        
        print("JSON: \(object.toJSON())")
        Alamofire.request(mainUrl, method: .post, parameters: object.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<GetProfileResponse>) in
                if let JSON = response.result.value
                {
                    
                    print("JSON: \(JSON.toJSON())")
                }
                if response.result.isSuccess {
                    
                   // self.getVitrinDataDelegate?.getSublistData(res: response.result.value!)
                    self.getProfileDelegate?.getProfileResponse(res: response.result.value!)
               // self.get
                }else{
                    
                }
                
        }
    }
    //MARK: playlist:
    func getPlayList(object : GetSublist) {
        
        Alamofire.request(mainUrl, method: .post, parameters: object.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<GetPlayListResponse>) in
                if let JSON = response.result.value
                {
                    
                    print("JSON: \(JSON)")
                }
                if response.result.isSuccess {
                    print(response.result.value?.items?[0].title)
                    self.playListNetDelegate?.getPlayListItems(res: response.result.value!,isSuccess : true)
                 
                }else{
                   // self.playListNetDelegate?.getPlayListItems(res: response.result.value!,isSuccess : false)
                }
                
        }
    }
    func addNewPlayList(object : NewPlayList) {
        
        Alamofire.request(mainUrl, method: .post, parameters: object.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<GetProfileResponse>) in
                if let JSON = response.result.value
                {
                    
                    print("JSON: \(JSON)")
                }
                if response.result.isSuccess {
                    
                    self.playListNetDelegate?.createNiewPlaylistResponse(res: true)
                    // self.getVitrinDataDelegate?.getSublistData(res: response.result.value!)
                    //self.getProfileDelegate?.getProfileResponse(res: response.result.value!)
                    // self.get
                }else{
                    self.playListNetDelegate?.createNiewPlaylistResponse(res: false)
                }
                
        }
    }
    func getComment(object : GetComment) {
    
        Alamofire.request(mainUrl, method: .post, parameters: object.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<GetComment>) in
                if let JSON = response.result.value
                {
                    
                    print("JSON: \(JSON)")
                }
                if response.result.isSuccess {
                   self.commentDelegate?.getCommentForItem(object: response.result.value!,success: true)

                }else{
                    let temp = GetComment()
                    self.commentDelegate?.getCommentForItem(object:temp, success: false)
               
                }
                
        }
    }
    func setComment(object : SetComment) {
        
        Alamofire.request(mainUrl, method: .post, parameters: object.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<SetComment>) in
                if let JSON = response.result.value
                {
                    
                    print("JSON: \(JSON)")
                }
                if response.result.isSuccess {
                    
                self.commentDelegate?.setCommentForItem(success: true)
                }else{
                 self.commentDelegate?.setCommentForItem(success: false)
                }
                
        }
    }
    
   
    
    
    func getContentList(object : GetContentList) {
    
       print("JSON: \(object.toJSONString(prettyPrint: true))")
        
        Alamofire.request(mainUrl, method: .post, parameters: object.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<GetContentListResponse>) in
                if let JSON = response.result.value
                {
                    
          print("JSON: \(JSON.toJSONString(prettyPrint: true))")
                }
                if response.result.isSuccess {
                self.getContentListDelegate?.getContentlistRes(res: response.result.value!)
                  
                }else{
                 
                    self.getContentListDelegate?.getContentlistResFailed(err: "\(response.result.error!)")
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
    
    
    
    
    func addToFavorite(object : AddToFavorite) {
        
        Alamofire.request(mainUrl, method: .post, parameters: object.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<CompleteInformationResponse>) in
                if let JSON = response.result.value
                {
                    
                    print("JSON: \(JSON)")
                }
                if response.result.isSuccess {
                //    self.getContentListDelegate?.getContentlistRes(res: response.result.value!)
                    self.addFavoriteDelegate?.addFavoriteRes(statusCode: (response.result.value?.code!)!)
                    
                }else{
                    self.addFavoriteDelegate?.addFavoriteRes(statusCode:"netProblem")
                   // self.getContentListDelegate?.getContentlistResFailed(err: "\(response.result.error!)")
                }
                
        }
        
        
    }
    
    func addToPlayList(object : AddToPlayList) {
        
        Alamofire.request(mainUrl, method: .post, parameters: object.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<CompleteInformationResponse>) in
                if let JSON = response.result.value
                {
                    
                    print("JSON: \(JSON)")
                }
                if response.result.isSuccess {
                    //    self.getContentListDelegate?.getContentlistRes(res: response.result.value!)
                    self.playListNetDelegate?.addToPlayListRes(res: (response.result.value)!)
                    
                }else{
                     self.playListNetDelegate?.addToPlayListRes(res: (response.result.value)!)
                    // self.getContentListDelegate?.getContentlistResFailed(err: "\(response.result.error!)")
                }
                
        }
        
        
    }
    
    
    
    func searchItem(object : SearchItem) {
        
        Alamofire.request(mainUrl, method: .post, parameters: object.toJSON(),encoding:JSONEncoding.default).responseObject
            { (response: DataResponse<GetPlayListResponse>) in
                if let JSON = response.result.value
                {
                    
                    print("JSON: \(JSON)")
                }
                if response.result.isSuccess {
    
                    self.searchDelegate?.searchError(success: true)
                    self.searchDelegate?.searchResponse(res: response.result.value!)
                }else{
       
                     self.searchDelegate?.searchError(success: false)
                    
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
