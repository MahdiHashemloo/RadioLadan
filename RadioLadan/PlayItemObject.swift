//
//  PlayItemObject.swift
//  RadioLadan
//
//  Created by Apple on 6/23/17.
//  Copyright © 2017 MHDY. All rights reserved.
//

import Foundation
class PlayItemObject: NSObject {
    //compare types:
    var image : String
    var refererType : String? //"playlist" or "vitrin"
    var id : String?
    var refererId : String?
    override init() {
        image = ""
       refererId = ""
        id = ""
        refererType = ""
    }
    
}
