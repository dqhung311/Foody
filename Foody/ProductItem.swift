//
//  ProductItem.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/25/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class ProductItem{
    var id: String = ""
    var name: String = ""
    var code: String = ""
    var urlphoto: String = ""
    var address: String = ""
    var score: String = ""
    var price: String = ""
    var province_id: String = ""
    var province_name: String = ""
    var category_id: String = ""
    var category_name: String = ""
    var otherimage = [String]()
    var comment_list = [String]()
    var total_like: Int = 0
    var total_comment: Int = 0
    var userid: String = ""
    
    
    init(){
        
    }
    init(id: String, name: String, code: String, urlphoto: String,address: String, score: String, price: String, province_id: String, category_id: String, province_name: String, category_name: String, otherimage: [String],
         comment_list: [String],
         total_like: Int, total_comment: Int,
         userid: String
         ) {
        self.code = code
        self.id = id
        self.name = name
        self.urlphoto = urlphoto
        self.address = address
        self.score = score
        self.price = price
        self.province_id = province_id
        self.province_name = province_name
        self.category_id = category_id
        self.category_name = category_name
        self.otherimage = otherimage
        self.total_like = total_like
        self.total_comment = total_comment
        self.userid = userid
        self.comment_list = comment_list
    }
  
    
    
}
