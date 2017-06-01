//
//  CollectionService.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/31/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import Foundation
class CollectionService{
    
    var urlJson: String = "http://anphatkhanh.vn/foody/collection/"
    private let session : URLSession!
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func fetchCollection(strUrl: String, completion:  @escaping ([CollectionItem], NSError?) -> Void){
        
        if(strUrl != ""){
            urlJson = strUrl
        }
        guard let url = URL(string: urlJson) else {
            let error = NSError(domain: "CollectionService", code: 404, userInfo: [NSLocalizedDescriptionKey: "URL is invalid!"])
            completion([], error)
            return
        }
        let task = session.dataTask(with: url, completionHandler: {[weak self] (data, res, err) in
            guard let jsonData = data, let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {
                let error = NSError(domain: "CollectionService", code: 501, userInfo: [NSLocalizedDescriptionKey: "Response is invalid!"])
                completion([], error)
                
                return
            }
            self?.parseJson(json: jsonObject as? [String: Any], completion: completion)
        })
        task.resume()
    }
    
    func parseJson(json: [String: Any]?, completion: ([CollectionItem], NSError?) -> Void){
        var collectionItems = [CollectionItem]()
        if let collection = json?["collection"] as? [[String:Any]] {
            for p in collection{
                //if let item = object as? ProductItem {
                let item = CollectionItem()
                if let id = p["id"] as? String {
                    item.id = id
                }
                if let product_id = p["product_id"] as? String {
                    item.product_id = product_id
                }
                if let product_address = p["product_address"] as? String {
                    item.product_address = product_address
                }
                if let product_image = p["product_image"] as? String {
                    item.product_image = product_image
                }
                if let product_name = p["product_name"] as? String {
                    item.product_name = product_name
                }
                if let total_like = p["total_like"] as? String {
                    item.total_like = total_like
                }
                
                collectionItems.append(item)
                
            }
        }
        print(collectionItems.count)
        completion(collectionItems, nil)
        
    }
    
}
