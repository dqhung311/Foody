//
//  FoodyAPI.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/29/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import Foundation
import UIKit
import AFNetworking

class FoodyAPI{
    
    
    var categoryList  = [ProductCategory]()
    var provinceList = [ProductProvince]()
    
    private let manager: AFHTTPSessionManager!
    
    init() {
        manager = AFHTTPSessionManager()
    }
    
    
    func getProducts(urlString: String){
       self.getJSON(url: urlString)
    }
    
    func getJSON(url: String) -> Any {
        var productList  = [ProductItem]()
        manager.get(
            url,
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
                            productList.append(item)
                            //}
                        }
                    }
                    //print(productList.count)
                    //Category
                    /*if let category = jsonDict["category"] as? [[String:Any]] {
                        
                        self.categoryList = []
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
                            self.categoryList.append(item)
                            
                        }
                        
                    }
                    //Province
                    if let province = jsonDict["province"] as? [[String:Any]] {
                        
                        self.provinceList = []
                        for p in province{
                            let item = ProductProvince()
                            
                            if let id = p["id"] as? String {
                                item.id = id
                            }
                            if let name = p["name"] as? String {
                                item.name = name
                            }
                            if let code = p["code"] as? String {
                                item.code = code
                            }
                            self.provinceList.append(item)
                            
                        }
                        
                    }*/
                    
                }
                
        },
            failure:
            {
                (operation, error) in
                print("Error: " + error.localizedDescription)
        })
        
        return productList
    }
    
    
    
    
}
