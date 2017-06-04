//
//  Users.swift
//  Foody
//
//  Created by Le NK on 5/29/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class Users{
    var email: String
    var password: String
    var name: String
    
    init() {
        self.email = ""
        self.password = ""
        self.name = ""
    }
    
    init(_ email: String, _ password: String, _ name: String) {
        self.email = email
        self.password = password
        self.name = name
    }    
}
