//
//  ProductCategory.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/25/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class ProductCategory{
    var id: String = ""
    var name: String = ""
    var code: String = ""
    var urlphoto: String = ""
    init(){
        
    }
    init(id: String, name: String, code: String, urlphoto: String) {
        self.code = code
        self.id = id
        self.name = name
        self.urlphoto = urlphoto
    }
    
    
}
