//
//  Users.swift
//  Foody
//
//  Created by Le NK on 5/29/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class Users: NSObject {
    private var email: String
    private var password: String
    private var name: String
    private var phone: String?
    
    init(_ email: String, _ password: String, _ name: String) {
        self.email = email
        self.password = password
        self.name = name
        
        super.init()
    }
    
    func getEmail() -> String{
        return self.email
    }
    
    func getPassword() -> String{
        return self.password
    }
    
    func getName() -> String{
        return self.name
    }
    
}
