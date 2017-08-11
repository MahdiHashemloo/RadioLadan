//
//  SendObjects.swift
//  RadioLadan
//
//  Created by Apple on 4/25/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import Foundation
import ObjectMapper
//1,2,3,4,5,6,7,12,17,19,22



//getContentDetail:





//add to favorite
// {"type":"add_fave","section":"content","item_id":"1","user_id":"1"}



class AddToFavorite: Mappable {
    
    var type: String?
    var section: String?
    var item_id: String?
    var user_id: String?
   
    required init?(map: Map){
        
    }
    init() {
        
        type = "add_fave"
        section = "content"
        item_id = ""
        user_id = "1"
      
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        section <- map["section"]
        item_id <- map["item_id"]
        user_id <- map["user_id"]
 
    }
}



//upload:
//{"type":"set_doc","title":"232","note":"wewew","festival_id":"wew","user_id":"23","format":"png"}

class UploadRequest: Mappable {
    
    var type: String?
    var title: String?
    var note: String?
    var user_id: String?
    var festival_id : String?
    var format : String?
    required init?(map: Map){
        
    }
    init() {
        
        type = "set_doc"
        title = "vitrin"
        note = ""
        user_id = "1"
        festival_id = ""
        format = ""
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        title <- map["title"]
        note <- map["note"]
        user_id <- map["user_id"]
        festival_id <- map["festival_id"]
        format <- map["format"]
    }
}





//get comment
//	19.	{"type":"get_comments","section":"content,playlist,author","item_id":"1","user_id":"1"}
//send:{"type":"get_comments","section":"content","item_id":"5","user_id":"2","page":"0","num":"10"}

//res:
//{"comments":[{"id":"3","user_avatar":"KO191542IW387483.jpg","user_fullname":"","content":"fgzsdfvzsd","date":"1396\/01\/29","time":"17:29:35"}],"code":"100","message":"Operation was succsessful."}

class GetComment: Mappable {
    
    var type: String?
    var section: String?
    var item_id: String?
    var user_id: String?
    var comments : [Comment]?
    var page : String?
    var num : String?
    var code : String?
    var message : String?
    required init?(map: Map){
        
    }
    init() {
        
        type = "get_comments"
        section = "vitrin"
        item_id = ""
        user_id = "1"
        comments = [Comment]()
        page = "0"
        num = "10"
        code = ""
        message = ""
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        section <- map["section"]
        item_id <- map["item_id"]
        user_id <- map["user_id"]
        comments <- map["comments"]
        page <- map["page"]
        num <- map["num"]
        code <- map["code"]
        message <- map["message"]
    }
}


//{"comments":[{"id":"3","user_avatar":"KO191542IW387483.jpg","user_fullname":"","content":"fgzsdfvzsd","date":"1396\/01\/29","time":"17:29:35"}],"code":"100","message":"Operation was succsessful."}
class Comment: Mappable {
    
    var id: String?
    var user_avatar: String?
    var user_fullname: String?
    var content: String?
    var date : String?
    var time : String?
    required init?(map: Map){
        
    }
    init() {
        
        id = "get_comments"
        user_avatar = "vitrin"
        user_fullname = ""
        content = ""
        date = ""
        time = ""
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        user_avatar <- map["user_avatar"]
        user_fullname <- map["user_fullname"]
        content <- map["content"]
        date <- map["date"]
        time <- map["time"]
    }
}


//setcomment
//17.	{"type":"set_comments","section":"content,playlist,author","item_id":"1","user_id":"1","comment":"متن نظر ..."} اصلاح شده
class SetComment: Mappable {
    
    var type: String?
    var section: String?
    var item_id: String?
    var user_id: String?
    var comment : String?
    var code : String?
    var message : String?
    required init?(map: Map){
        
    }
    init() {
        
        type = "set_comments"
        section = "content"
        item_id = ""
        user_id = "1"
        comment = ""
        code = ""
        message = ""
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        section <- map["section"]
        item_id <- map["item_id"]
        user_id <- map["user_id"]
        comment <- map["comment"]
        code <- map["code"]
        message <- map["message"]
    }
}





// MARK: ==========newPlayList============
//{"type":"add_playlist","title":"لیست پخش عید","note":"توضیحات","user_id":"1"}
class NewPlayList: Mappable {
    
    var type: String?
    var title: String?
    var note: String?
   // var place: String?
    var user_id : String?
    required init?(map: Map){
        
    }
    init() {
        
        type = "add_to_playlist"
        title = "name"
        note = ""
   //     place = ""
        user_id = "1"
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        title <- map["title"]
        note <- map["note"]
   //     place <- map["place"]
        user_id <- map["user_id"]
    }
}

/*
 "playlist_id": "13",
	"place": "1",
	"user_id": "11",
	"type": "add_to_playlist",
	"content_id": "0"
 }
 */
//add to playlist:12{"type":"add_to_playlist","playlist_id":"2","content_id":"1","place":"2","user_id":"1"}
class AddToPlayList: Mappable {
    
    var type: String?
    var playlist_id: String?
    var content_id: String?
    var place: String?
    var user_id : String?
    required init?(map: Map){
        
    }
    init() {
        
        type = "add_to_playlist"
        playlist_id = "vitrin"
        content_id = ""
        place = "1"
        user_id = "1"
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        playlist_id <- map["playlist_id"]
        content_id <- map["content_id"]
        place <- map["place"]
        user_id <- map["user_id"]
    }
}


//get sublist:
//7{"type":"sub_list","list_type":"cat","user_id":"1","key_word":"","page":"0","num":"10"}
class GetSublist: Mappable {
    
    var type: String?
    var list_type: String?
    var user_id: String?
    var key_word: String?
    var page : String?
    var num : String?
    
    
    required init?(map: Map){
        
    }
    init() {
        
        type = "sub_list"
        list_type = "cat"
        user_id = "1"
        key_word = ""
        page = "0"
        num = "10"
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        list_type <- map["list_type"]
        user_id <- map["user_id"]
        key_word <- map["refferer_id"]
        page <- map["page"]
        num <- map["num"]
        
    }
}
//--
//get one song and related:22
//{"type":"content_detail","id":"7","refferer_type":"vitrin","refferer_id":"0"}
class GetMusicFromVitrin: Mappable {
    
    var type: String?
    var refferer_type: String?
    var id: String?
    var refferer_id: String?
    var user_id : String?
       required init?(map: Map){
        
    }
    init() {
        
        type = "content_detail"
        refferer_type = "vitrin"
        id = ""
        refferer_id = ""
        user_id = "1"
            }
    
    func mapping(map: Map) {
        type <- map["type"]
        refferer_type <- map["refferer_type"]
        id <- map["id"]
        refferer_id <- map["refferer_id"]
        user_id <- map["user_id"]
               
    }
}

//searchItem
//{"type":"content_list","list_type":"search","user_id":"20","key_word":"کله","page":"0","num":"10"}




class SearchItem: Mappable {
    
    var type: String?
    var list_type: String?
    var key_word: String?
    var page: String?
    var user_id : String?
    var num : String?
    required init?(map: Map){
        
    }
    init() {
        
        type = "content_list"
        list_type = "search"
        key_word = ""
        page = "0"
        user_id = "1"
        num = "10"
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        list_type <- map["list_type"]
        key_word <- map["key_word"]
        page <- map["page"]
        user_id <- map["user_id"]
        num <- map["num"]
        
    }
}



//moshahede hame
//6{"type":"content_list","list_type":"cat,author,vitrin,playlist,genre","id":"1","user_id":"1","key_word":"","page":"0","num":"10"}



class GetContentList: Mappable {
    
    var type: String?
    var list_type: String?
    var id: String?
    var user_id: String?
    var key_word: String?
    var page: String?
    var num : String?
    var sort_type : String?
    //popular//newest//most_view
    required init?(map: Map)
    {
        
    }
    init() {
        
        type = "content_list"
        list_type = "vitrin"
        id = ""
        user_id = "1"
        key_word = ""
        page = "0"
        num = "10"
        sort_type = ""
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        list_type <- map["list_type"]
        id <- map["id"]
        user_id <- map["user_id"]
        key_word <- map["key_word"]
        page <- map["mobile"]
        num <- map["num"]
        sort_type <- map["sort_type"]
        
    }
}


//5{"type":"vitrin"}

class GetVitrin: Mappable {
    
    var type: String?
    
    required init?(map: Map){
        
    }
    init() {
        
        type = "vitrin"
     
        
    }
    
    func mapping(map: Map) {
        type <- map["type"]
       
        
    }
}


//4{"type":"get_profile","user_id":"1"}

class GetProfile: Mappable {
    
    var type: String?
    var user_id: String?
    
    required init?(map: Map){
        
    }
    init() {
        
        type = "get_profile"
        user_id = "1"
        
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        user_id <- map["user_id"]
        
    }
}






//3{"type":"set_profile","user_id":"1","fname":"حمیدرضا","lname":"صفی پور","email":"shaltoook@gmail.com","mobile":"09124153184"}


class SetProfile: Mappable {
    
    var type: String?
    var user_id: String?
    var fname: String?
    var lname: String?
    var email: String?
    var mobile: String?
    var avatar : String?
    required init?(map: Map){
        
    }
    init() {
        
        type = "set_profile"
        user_id = ""//from server
        fname = ""
        lname = ""
        email = ""
        mobile = ""
        avatar = ""
        
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        user_id <- map["user_id"]
        fname <- map["fname"]
        lname <- map["lname"]
        email <- map["email"]
        mobile <- map["mobile"]
        avatar <- map["avatar"]
        
    }
}








//activate COde
//1 {"type":"active_code","user_id":"1","code":"1212"}


class ActivateCode: Mappable {
    
    var type: String?
    var user_id: String?
    var code: String?
    
    
    required init?(map: Map){
        
    }
    init() {
        
        type = "active_code"
        user_id = "1"
        code = ""
        
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        user_id <- map["user_id"]
        code <- map["code"]
        
        
    }
}



//register
//	2.	{"type":"register","mobile":"09124153184","device_info":[{"os":"android","model":"g2","sim":"0","sui":"61725726354297","resolution":"","app_version":"1.0"}]}
class NumRegister: Mappable {
    
    var type: String?
    var mobile: String?
    var device_info: [Device_info]?
   
    
    required init?(map: Map){
        
    }
    init() {
        
        type = "register"
        mobile = ""
        device_info = [Device_info]()
        
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        mobile <- map["mobile"]
        device_info <- map["device_info"]
        
        
    }
}


class Device_info: Mappable {
    var os: String?
    var model: String?
    var sim: String?
    var sui: String?
    var resolution: String?
    var app_version : String?
    
    required init?(map: Map){
        
    }
    init() {
        
        os = "ios"
        model = ""
        sim = "0"
        sui = ""
        resolution = ""
        app_version = ""
        
    }
    
    func mapping(map: Map) {
        os <- map["os"]
        model <- map["model"]
        sim <- map["sim"]
        sui <- map["sui"]
        resolution <- map["resolution"]
        app_version <- map["app_version"]
        
        
    }
}
