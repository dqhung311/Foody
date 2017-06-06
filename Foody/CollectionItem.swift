//
//  Collection.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/31/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//


import UIKit

class CollectionItem{
    var id: String = ""
    var product_id: String = ""
    var product_name: String = ""
    var product_image: String = ""
    var product_address: String = ""
    var total_like: String = ""
    var product_score: String = ""
    var product_province_name: String = ""
    var product_category_name: String = ""
    var product_price: String = ""
    
    
    init(){
        
    }
    init(id: String, product_name: String, product_id: String, product_image: String,product_address: String, total_like: String,
         product_score: String,
         product_province_name: String,
         product_category_name: String,
         product_price: String
         ){
        
        self.id = id
        self.product_id = product_id
        self.product_name = product_name
        self.product_image = product_image
        self.product_address = product_address
        self.total_like = total_like
        self.product_score = product_score
        self.product_province_name = product_province_name
        self.product_category_name = product_category_name
        self.product_price = product_price
        
    }
    
    
    
}
