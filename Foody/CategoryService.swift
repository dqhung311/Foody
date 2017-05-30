//
//  ProductService.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/30/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class CategoryService{
    
    let urlJson: String = "http://anphatkhanh.vn/foody/category/"
    private let session : URLSession!
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func fetchCategory(completion:  @escaping ([ProductCategory], NSError?) -> Void){
        guard let url = URL(string: urlJson) else {
            let error = NSError(domain: "CategoryService", code: 404, userInfo: [NSLocalizedDescriptionKey: "URL is invalid!"])
            completion([], error)
            return
        }
        
        let task = session.dataTask(with: url, completionHandler: {[weak self] (data, res, err) in
            guard let jsonData = data, let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {
                let error = NSError(domain: "CategoryService", code: 501, userInfo: [NSLocalizedDescriptionKey: "Response is invalid!"])
                completion([], error)
                return
            }
            
            self?.parseJson(json: jsonObject as? [String: Any], completion: completion)
        })
        
        task.resume()
    }
    
    
    func parseJson(json: [String: Any]?, completion: ([ProductCategory], NSError?) -> Void){
        var categoryItem = [ProductCategory]()
        if let category = json?["category"] as? [[String:Any]] {
            for p in category{
                let item = ProductCategory()
                if let id = p["id"] as? String {
                    item.id = id
                }
                if let name = p["name"] as? String {
                    item.name = name
                }
                if let code = p["code"] as? String {
                    item.code = code
                }
                if let urlphoto = p["urlphoto"] as? String {
                    item.urlphoto = urlphoto
                }
                categoryItem.append(item)
                
            }
        }
        completion(categoryItem, nil)
        
    }
    
    
    
}
