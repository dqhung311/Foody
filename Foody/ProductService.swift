//
//  ProductService.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/30/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit
import AFNetworking

class ProductService{
    
    let urlJson: String = "http://anphatkhanh.vn/foody/json.php"
    //let manager: AFHTTPSessionManager!
    
    init(){
        //manager = AFHTTPSessionManager()
    }
    
    
    func getAllProduct(urlString: String, completion:  @escaping ([ProductItem], NSError?) -> Void){
        self.parseJson(urlString: urlString,completion: completion )
    }
    
    
    func parseJson(urlString: String, completion: ([ProductItem], NSError?) -> Void){
        let manager = AFHTTPSessionManager()
        var productItems = [ProductItem]()
        
        manager.get(
            urlString,
            parameters: nil,
            success:
            {
                (operation, responseObject) in
                
                if let jsonDict = responseObject as? [String: Any] {
                    if let product = jsonDict["product"] as? [[String:Any]] {
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
                        print(productItems.count)
                    }
                    
                }
                
        },
            failure:
            {
                (operation, error) in
                print("Error: " + error.localizedDescription)
        })
        print(productItems.count)
        completion(productItems, nil)
        
    }
    
}
