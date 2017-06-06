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
    
    init(){
        
    }
    init(id: String, name: String, code: String, urlphoto: String,address: String, score: String, price: String, province_id: String, category_id: String, province_name: String, category_name: String ) {
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
    }
  
    
    
}
