//
//  CollectionService.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/31/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

protocol ProtocolCollectionService {
    
    func fetchAllCollection(_ query: String, completion: @escaping ([CollectionItem], NSError?) -> Void)
    
    func fetchByID(_ id: String, completion: @escaping ([CollectionItem], NSError?) -> Void)
    
    func updateCollection(_ id: String) -> String
    
    func addNewCollection(sender: AnyObject, handler:@escaping (_ result:String?)-> Void)
}


import Foundation
class CollectionService: ProtocolCollectionService{
    
    var urlCollection: String = "http://anphatkhanh.vn/foody/collection/"
    var urlEditCollection: String = "http://anphatkhanh.vn/foody/collection/edit.php"
    
    private let session : URLSession!
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    
    func addNewCollection(sender: AnyObject, handler: @escaping (String?) -> Void) {
        
        if let collection = sender as? CollectionItem {
            
            let param = [
                "productid" : collection.product_id,
                "userid": collection.user_id,
             ] as NSMutableDictionary
            
            
            let boundary = "Boundary-\(NSUUID().uuidString)"
            let url = NSURL(string: urlEditCollection)
            let request = NSMutableURLRequest(url: url! as URL)
            
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = Config().createBodyWithParameters(parameters: param, boundary: boundary) as Data
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                let responseString = String(data: data, encoding: .utf8) ?? ""
                handler(responseString)
                
            })
            task.resume()
        }
    }
    
    func updateCollection(_ id: String) -> String {
        return ""
    }

    func fetchByID(_ id: String, completion:  @escaping ([CollectionItem], NSError?) -> Void){
        self.fetchAllCollection("?id=" + id, completion: completion)
    }

    
    func fetchAllCollection(_ query: String, completion:  @escaping ([CollectionItem], NSError?) -> Void){
        let urlJson: String
        if(query != ""){
            urlJson = urlCollection + query
        }else{
            urlJson = urlCollection
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
                if let total_like = p["total_like"] as? Int {
                    item.total_like = total_like
                }
                if let product_score = p["product_score"] as? String {
                    item.product_score = product_score
                }
                if let product_province_name = p["product_province_name"] as? String {
                    item.product_province_name = product_province_name
                }
                if let product_category_name = p["product_category_name"] as? String {
                    item.product_category_name = product_category_name
                }
                if let product_province_id = p["product_province_id"] as? String {
                    item.product_province_id = product_province_id
                }
                if let product_category_id = p["product_category_id"] as? String {
                    item.product_category_id = product_category_id
                }
                if let product_price = p["product_price"] as? String {
                    item.product_price = product_price
                }
                if let total_comment = p["total_comment"] as? Int {
                    item.total_comment = total_comment
                }
                if let product_otherimage = p["product_otherimage"] as? [String] {
                    item.product_otherimage = product_otherimage
                }
                
                
                
                collectionItems.append(item)
                
            }
        }
        completion(collectionItems, nil)
        
    }
    
}
