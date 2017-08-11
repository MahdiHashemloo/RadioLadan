//
//  RecievingObjects.swift
//  RadioLadan
//
//  Created by Apple on 4/25/17.
//  Copyright © 2017 MHDY. All rights reserved.
//
import ObjectMapper
import Foundation

//{"id":"7","title":"\u0628\u0647\u062a\u0631\u06cc\u0646 \u0647\u0627\u06cc \u06a9\u0644\u0647\u0631","cat_ids":null,"authors":null,"genre":"\u0645\u0648\u0632\u06cc\u06a9","file":"http:\/\/ihamsane.ir\/ladan\/admin\/uploads\/YK168499PH5296471.mp3","duration":"00:03:00","fav_num":1,"comment_num":0,"image":"http:\/\/ihamsane.ir\/ladan\/admin\/uploads\/BN810421YU2021620.jpg","album_name":""}

class GetContentListResponse: Mappable {
    

    var items: [item]?
    var code: String?
    var message: String?
    
    
    // var action: String?
    
    required init?(map: Map){
        
    }
    init() {
        
        
        items = [item]()
        code = "0"
        message = ""
        
    }
    
    func mapping(map: Map) {
        items <- map["items"]
        code <- map["code"]
        message <- map["message"]
        
        
        
    }
}

//
//{"items":[{"id":"12","title":"ff","image":"http:\/\/ihamsane.ir\/ladan\/admin\/uploads\/"},{"id":"13","title":"\u0644\u06cc\u0633\u062a \u067e\u062e\u0634 \u0639\u06cc\u062f","image":"http:\/\/ihamsane.ir\/ladan\/admin\/uploads\/"},{"id":"14","title":"2\u0644\u06cc\u0633\u062a \u067e\u062e\u0634 \u0639\u06cc\u062f","image":"http:\/\/ihamsane.ir\/ladan\/admin\/uploads\/"}],"code":"100","message":"Operation was succsessful."}
//{"id":"7","title":"\u0628\u0647\u062a\u0631\u06cc\u0646 \u0647\u0627\u06cc \u06a9\u0644\u0647\u0631","cat_ids":null,"authors":null,"genre":"\u0645\u0648\u0632\u06cc\u06a9","file":"http:\/\/ihamsane.ir\/ladan\/admin\/uploads\/YK168499PH5296471.mp3","duration":"00:03:00","fav_num":1,"comment_num":0,"image":"http:\/\/ihamsane.ir\/ladan\/admin\/uploads\/BN810421YU2021620.jpg","album_name":""}

class GetPlayListResponse: Mappable {
    
    
    var items: [item]?
    var code: String?
    var message: String?

    
    // var action: String?
    
    required init?(map: Map){
        
    }
    init() {
        
        
        items = [item]()
        code = "0"
        message = ""

    }
    
    func mapping(map: Map) {
        items <- map["items"]
        code <- map["code"]
        message <- map["message"]
 
        
        
    }
}







//getprofileResponse:
//{"fname":"","lname":"","email":"","mobile":"09337771221","fave":null,"docs":null,"code":"100","message":"Operation was succsessful."}
class GetProfileResponse: Mappable {
    
 
     var fname: String?
     var lname: String?
     var email: String?
     var mobile: String?
     var fave: [item]?
     var docs: String?
     var code: String?
    var avatar: String?
    var message: String?
    
    // var action: String?
    
    required init?(map: Map){
        
    }
    init() {
        
       
        fname = ""
        lname = "0"
        email = ""
        mobile = "0"
        fave = [item]()
        docs = "0"
        code = ""
        message = ""
        avatar = ""
               //   action = ""
    }
    
    func mapping(map: Map) {
        fname <- map["fname"]
        lname <- map["lname"]
        email <- map["email"]
        mobile <- map["mobile"]
        fave <- map["fave"]
        docs <- map["docs"]
        code <- map["code"]
        avatar <- map["avatar"]
        message <- map["message"]
               //   action <- map["action"]
        
        
    }
}

//GetSublistresponse
class GetSublistresponse: Mappable {
    
    var items: [item]?
    var code: String?
    var message: String?
    // var action: String?
    
    required init?(map: Map){
        
    }
    init() {
        
        items = [item]()
        code = ""
        message = "0"
        //   action = ""
    }
    
    func mapping(map: Map) {
        items <- map["items"]
        code <- map["code"]
        message <- map["message"]
        //   action <- map["action"]
        
        
    }
}

//--


//get one music and related from vitrin
//
class GetMusicFromVitrinResponse: Mappable {
    
    var id: String?
    var cat_ids: String?
    var authors: String?
    var genre: String?
    var title: String?
    var content: String?
   
    var related_items: [RelatedItems]?
    var file: String?
    var image: String?
    var code: String?
    var message: String?
    
    
    required init?(map: Map){
        
    }
    init() {
        
        id = "0"
        cat_ids = ""
        authors = ""
        genre = "0"
        title = ""
        content = ""
        
        related_items = [RelatedItems]()
        file = ""
        image = ""
        code = "0"
        message = ""
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        cat_ids <- map["cat_ids"]
        authors <- map["authors"]
        genre <- map["genre"]
        title <- map["title"]
        content <- map["content"]
      
        related_items <- map["related_items"]
        file <- map["file"]
        image <- map["image"]
        code <- map["code"]
        message <- map["message"]
        
        
    }
}

class RelatedItems: Mappable {
    
    var id: String?
    var cat_ids: String?
    var authors: String?

    var title: String?


    var file: String?
    var image: String?

    
    
    required init?(map: Map){
        
    }
    init() {
        
        id = "0"
        cat_ids = ""
        authors = ""

        title = ""

        

        file = ""
        image = ""


    }
    
    func mapping(map: Map) {
        id <- map["id"]
        cat_ids <- map["cat_ids"]
        authors <- map["authors"]

        title <- map["title"]

        

        file <- map["file"]
        image <- map["image"]
  
        
        
    }
}

//--------------
//vitrin:{"type":"vitrin"}
//=====
class vitrinResponse: Mappable {
    
    var banners: [Banner]?
    var vitrins: [vitrin]?
    var inline_banners: [inline_Banner]?
    var code: String?
    var message : String?
    
    required init?(map: Map){
        
    }
    init() {
        
        banners = [Banner]()
        vitrins = [vitrin]()
        inline_banners = [inline_Banner]()
        code = ""
        message = ""
    }
    
    func mapping(map: Map) {
        banners <- map["banners"]
        vitrins <- map["vitrins"]
        inline_banners <- map["inline_banners"]
        code <- map["code"]
        message <- map["message"]
        
        
    }
}

class Banner: Mappable {
    
    var title: String?
    var image: String?
    var link: String?
   // var action: String?
    
    required init?(map: Map){
        
    }
    init() {
        
        title = "0"
        image = ""
        link = "0"
     //   action = ""
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        image <- map["image"]
        link <- map["link"]
     //   action <- map["action"]
        
        
    }
}

class vitrin: Mappable {
    
    var id: String?
    var title: String?
    var place: String?
    var items: [item]?
    
    required init?(map: Map){
        
    }
    init() {
        
        id = "0"
        title = ""
        place = "0"
        items = [item]()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        place <- map["place"]
        items <- map["items"]
        
        
    }
}

class item: Mappable {
    
    var id: String?
    var title: String?
    var image: String?
   // var id : String?
   // var title : String?
    var cat_ids : String?
    var authors : String?
    var genre : String?
    var file : String?
    var duration : String?
    var fav_num :String?
    var comment_num : String?
    var is_fave : String?
    //var image : String?
    var album_name : String?
    required init?(map: Map){
        
    }
    init() {
        
        id = "0"
        title = ""
        image = "0"
        cat_ids = ""
        authors = ""
        genre = ""
        file = ""
        duration = ""
        fav_num = ""
        comment_num = ""
        album_name = ""
        is_fave = ""
        
    
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        image <- map["image"]
        cat_ids <- map["cat_ids"]
        authors <- map["authors"]
        genre <- map["genre"]
        file <- map["file"]
        duration <- map["duration"]
        fav_num <- map["fav_num"]
        comment_num <- map["comment_num"]
        album_name <- map["album_name"]
        is_fave <- map["is_fave"]
    
        
        
    }
}


class inline_Banner: Mappable {
    
    
    var title: String?
    var place: String?
    var image: String?
    var link: String?

   // var action: String?
    
    required init?(map: Map){
        
    }
    init() {
        
        title = "0"
        place = ""
        image = "0"
        link = ""
        //action = ""
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        place <- map["place"]
        image <- map["image"]
        link <- map["link"]
      // action <- map["action"]
        
    }
}


//======
class CompleteInformationResponse: Mappable {
    
    var code: String?
    var message: String?
    
    
    required init?(map: Map){
        
    }
    init() {
        
        code = "0"
        message = ""
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        
        
    }
}


class ActivateCodeResponse: Mappable {
    
    var user_id: String?
    var user_info: String?
    
    var code: String?
    var message: String?
    
    required init?(map: Map){
        
    }
    init() {
        
        user_id = "1"
        user_info = ""
        
        code = ""
        message = ""
            }
    
    func mapping(map: Map) {
        user_id <- map["user_id"]
        user_info <- map["user_info"]
        code <- map["code"]
        message <- map["message"]
        
        
    }
}
//{"fname":"","lname":"","email":"","avatar":"http:\/\/ihamsane.ir\/ladan\/admin\/uploads\/","gender":null,"mobile":"09202021889"},"code":"100","message":"Operation was succsessful."}
class User_Info: Mappable {
    
    var fname: String?
    var lname: String?
    var email: String?
    var avatar: String?
    var gender: String?
    var mobile: String?
    var user_info: String?
    
    
    required init?(map: Map){
        
    }
    init() {
        
        fname = "0"
        lname = ""
        email = ""
        avatar = ""
        gender = ""
        mobile = ""
        user_info = ""
    }
    
    func mapping(map: Map) {
        fname <- map["fname"]
        lname <- map["lname"]
        email <- map["email"]
        avatar <- map["avatar"]
        gender <- map["gender"]
        mobile <- map["mobile"]
        user_info <- map["user_info"]
       
        
        
    }
}


//
class NumRegisterResponse: Mappable {
    
    var user_id: String?
    var code: String?
    var message: String?
    
    
    required init?(map: Map){
        
    }
    init() {
        
        user_id = "1"
        code = ""
        message = ""
    }
    
    func mapping(map: Map) {
        user_id <- map["user_id"]
        code <- map["code"]
        message <- map["message"]
        
        
    }
}
//searchResponse

//{"items":[{"id":"7","title":"\u0628\u0647\u062a\u0631\u06cc\u0646 \u0647\u0627\u06cc \u06a9\u0644\u0647\u0631","cat_ids":null,"authors":null,"genre":"\u0645\u0648\u0632\u06cc\u06a9","file":"http:\/\/ihamsane.ir\/ladan\/admin\/uploads\/YK168499PH5296471.mp3","duration":"00:03:00","fav_num":2,"comment_num":0,"image":"http:\/\/ihamsane.ir\/ladan\/admin\/uploads\/BN810421YU2021620.jpg","album_name":""}],"code":"100","message":"Operation was succsessful."}




