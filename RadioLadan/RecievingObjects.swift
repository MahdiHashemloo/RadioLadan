//
//  RecievingObjects.swift
//  RadioLadan
//
//  Created by Apple on 4/25/17.
//  Copyright © 2017 MHDY. All rights reserved.
//
import ObjectMapper
import Foundation
//
//getprofileResponse:


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
    
    required init?(map: Map){
        
    }
    init() {
        
        id = "0"
        title = ""
        image = "0"
    
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        image <- map["image"]
    
        
        
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
    
    
    required init?(map: Map){
        
    }
    init() {
        
        user_id = "0"
        user_info = ""
            }
    
    func mapping(map: Map) {
        user_id <- map["user_id"]
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
        
        user_id = "0"
        code = ""
        message = ""
    }
    
    func mapping(map: Map) {
        user_id <- map["user_id"]
        code <- map["code"]
        message <- map["message"]
        
        
    }
}
