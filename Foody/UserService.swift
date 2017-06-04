//
//  UserService.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/30/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class UserService {
    let urlJson = "http://anphatkhanh.vn/foody/user/?"
    
    private let session : URLSession!
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func fetchUser(completion:  @escaping ([Users], NSError?) -> Void){
        guard let url = URL(string: urlJson) else {
            let error = NSError(domain: "UserService", code: 404, userInfo: [NSLocalizedDescriptionKey: "URL is invalid!"])
            completion([], error)
            return
        }
        
        let task = session.dataTask(with: url, completionHandler: {[weak self] (data, res, err) in
            guard let jsonData = data, let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {
                let error = NSError(domain: "UserService", code: 501, userInfo: [NSLocalizedDescriptionKey: "Response is invalid!"])
                completion([], error)
                return
            }
            
            self?.parseJson(json: jsonObject as? [String: Any], completion: completion)
        })
        
        task.resume()
    }
    
    
    func parseJson(json: [String: Any]?, completion: ([Users], NSError?) -> Void){
        var userStore = [Users]()
        if let user = json?["user"] as? [[String:Any]] {
            for p in user{
                let user = Users()
                if let email = p["email"] as? String {
                    user.email = email
                }
                if let password = p["password"] as? String {
                    user.password = password
                }
                if let name = p["name"] as? String {
                    user.name = name
                }
                userStore.append(user)
            }
        }
        completion(userStore, nil)
    }
    
}
