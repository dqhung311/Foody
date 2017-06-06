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
    
    func fetchByID(id: String, completion: @escaping ([ProductItem], NSError?) -> Void)
    
    func updateProduct(_ id: String) -> String
    
    func addNewProduct() -> String

}
class ProductService:ProtocolProductService{
    
    let urlJson: String = "http://anphatkhanh.vn/foody/product/?"
    private let session : URLSession!
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func addNewProduct() -> String {
        return ""
    }
    
    func updateProduct(_ id: String) -> String {
        return ""
    }
    
    func fetchByID(id: String, completion:  @escaping ([ProductItem], NSError?) -> Void){
        self.fetchAllProduct(query: "id=" + id, completion: completion)
    }
    
    func fetchAllProduct(query: String, completion:  @escaping ([ProductItem], NSError?) -> Void){
        var urlJsonRes: String = urlJson
        if(query != ""){
            urlJsonRes = urlJson + query
        }
        print(urlJsonRes)
        guard let url = URL(string: urlJsonRes) else {
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
                            if let price = p["price"] as? String {
                                item.price = price
                            }
                            if let category_id = p["category_id"] as? String {
                                item.category_id = category_id
                            }
                            if let category_name = p["category_name"] as? String {
                                item.category_name = category_name
                            }
                            if let province_id = p["province_id"] as? String {
                                item.province_id = province_id
                            }
                            if let province_name = p["province_name"] as? String {
                                item.province_name = province_name
                            }
                            productItems.append(item)
                            
                        }
                    }
        completion(productItems, nil)
                    
    }
    
}
