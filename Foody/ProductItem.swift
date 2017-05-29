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
    init(){
        
    }
    init(id: String, name: String, code: String, urlphoto: String,address: String, score: String) {
        self.code = code
        self.id = id
        self.name = name
        self.urlphoto = urlphoto
        self.address = address
        self.score = score
    }
    
    
}
