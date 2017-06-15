//
//  Comment.swift
//  Foody
//
//  Created by Le NK on 6/6/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class Comments{
    var id: String
    var name: String
    var comment: String
    var user_id: String
    var product_id: String
    var product_address: String
    var product_name: String
    var product_image: String
    var product_score: String
    var product_province_name: String
    var product_category_name: String
    var product_price: String
    var total_like: String
    
    init() {
        self.id = ""
        self.name = ""
        self.comment = ""
        self.product_id = ""
        self.product_address = ""
        self.product_name = ""
        self.product_image = ""
        self.product_score = ""
        self.product_province_name = ""
        self.product_category_name = ""
        self.product_price = ""
        self.total_like = ""
        self.user_id = ""
    }
    
}
