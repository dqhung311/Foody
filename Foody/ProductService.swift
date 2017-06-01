//
//  ProductService.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/30/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit
protocol ProtocolProductService {
    func fetchAllProduct(query: String, completion: @escaping ([ProductItem], NSError?) -> Void)
    
}
class ProductService:ProtocolProductService{
    
    var urlJson: String = "http://anphatkhanh.vn/foody/product/"
    private let session : URLSession!
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func fetchAllProduct(query: String, completion:  @escaping ([ProductItem], NSError?) -> Void){
        
        if(query != ""){
            urlJson += query
        }
        guard let url = URL(string: urlJson) else {
            let error = NSError(domain: "ProductService", code: 404, userInfo: [NSLocalizedDescriptionKey: "URL is invalid!"])
            completion([], error)
            return
        }
        let task = session.dataTask(with: url, completionHandler: {[weak self] (data, res, err) in
            guard let jsonData = data, let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {
                let error = NSError(domain: "ProductService", code: 501, userInfo: [NSLocalizedDescriptionKey: "Response is invalid!"])
                completion([], error)
                
                return
            }
            self?.parseJson(json: jsonObject as? [String: Any], completion: completion)
        })
        task.resume()
    }
    
    func parseJson(json: [String: Any]?, completion: ([ProductItem], NSError?) -> Void){
        var productItems = [ProductItem]()
        if let product = json?["product"] as? [[String:Any]] {
                        for p in product{
                            
                            //if let item = object as? ProductItem {
                            let item = ProductItem()
                            if let id = p["id"] as? String {
                                item.id = id
                            }
                            if let name = p["name"] as? String {
                                item.name = name
                            }
                            if let code = p["code"] as? String {
                                item.code = code
                            }
                            if let address = p["address"] as? String {
                                item.address = address
                            }
                            if let urlphoto = p["preview_image"] as? String {
                                item.urlphoto = urlphoto
                            }
                            if let score = p["score"] as? String {
                                item.score = score
                            }
                            productItems.append(item)
                            
                        }
                    }
        completion(productItems, nil)
                    
    }
    
}
