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
    
    func insertUser() -> String{
        var request = URLRequest(url: URL(string: "http://anphatkhanh.vn/foody/edit.php")!)
        request.httpMethod = "POST"
        let postString = "email=\(self.getEmail())&password=\(self.getPassword())&name=\(self.getName())"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                return httpStatus.statusCode
//                DispatchQueue.main.async {
//                    self.showAlertMessage("statusCode should be 200, but is \(httpStatus.statusCode)")
//                }
            }
            
            let responseString = String(data: data, encoding: .utf8)
            let messageshow = responseString ?? ""
            return messageshow
//            if messageshow != "ok" {
//                
//                DispatchQueue.main.async {
//                    self.showAlertMessage(messageshow)
//                }
//            } else {
//                DispatchQueue.main.async {
//                    UserDefaults.standard.setValue(newuser.getPassword(), forKey: "password")
//                    self.showSuccessMessage("Đăng ký thành công")
//                }
//            }
            
        }
        task.resume()
        
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
