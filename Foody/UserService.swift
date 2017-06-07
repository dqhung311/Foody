//
//  UserService.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/30/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

protocol ProtocolUser {
    func fetchAllUser(query: String, completion: @escaping ([Users], NSError?) -> Void)
    func fetchUserByEmail(email: String, completion: @escaping ([Users], NSError?) -> Void)
}

class UserService:ProtocolUser {
    let urlJson = "http://anphatkhanh.vn/foody/user/?"
    let newUserUrl = "http://anphatkhanh.vn/foody/user/edit.php"
    
    private let session : URLSession!
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func fetchAllUser(query: String, completion:  @escaping ([Users], NSError?) -> Void){
        var urlJsonRes: String = urlJson
        if(query != ""){
            urlJsonRes = urlJson + query
        }
        guard let url = URL(string: urlJsonRes) else {
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
    
    func fetchUserByEmail(email: String, completion: @escaping ([Users], NSError?) -> Void) {
        fetchAllUser(query: "email="+email, completion: completion)
    }
    
    func parseJson(json: [String: Any]?, completion: ([Users], NSError?) -> Void){
        var userStore = [Users]()
        if let user = json?["users"] as? [[String:Any]] {
            for p in user{
                let user = Users()
                if let id = p["id"] as? String {
                    user.id = id
                }
                if let email = p["email"] as? String {
                    user.email = email
                }
                if let password = p["password"] as? String {
                    user.password = password
                }
                if let name = p["name"] as? String {
                    user.name = name
                }
                user.image_url = "http://www.iconsfind.com/wp-content/uploads/2015/08/20150831_55e46ad551392.png"
                userStore.append(user)
            }
        }
        completion(userStore, nil)
    }
    
    func registerUser(sender: AnyObject){
        if let user = sender as? Users{
            var request = URLRequest(url: URL(string: newUserUrl)!)
            request.httpMethod = "POST"
            let postString = "email=\(user.email)&password=\(user.password)&name=\(user.name)"
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                }
                
                let responseString = String(data: data, encoding: .utf8) ?? ""
                if(responseString == "ok"){
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Chúc mừng", message: "Đăng ký thành công", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler: nil))
                        
                        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
                        alertWindow.rootViewController = UIViewController()
                        alertWindow.windowLevel = UIWindowLevelAlert + 1;
                        alertWindow.makeKeyAndVisible()
                        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
                        
                        UserDefaults.standard.setValue(user.password, forKey: "password")
                        UserDefaults.standard.setValue(user.email, forKey: "email")
                        UserDefaults.standard.setValue(user.name, forKey: "name")
                    }
                }else{
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Lỗi", message: responseString, preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler: nil))
                    
                        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
                        alertWindow.rootViewController = UIViewController()
                        alertWindow.windowLevel = UIWindowLevelAlert + 1;
                        alertWindow.makeKeyAndVisible()
                        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
                    }
                }
            }
            task.resume()
        }
    }
}
