//
//  Config.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/30/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import Foundation
import UIKit

class Config{
    let tabProduct: String = "Product"
    let tabCategory: String = "Category"
    let tabProvince: String = "Province"
    let tabMyCollection: String = "MyCollection"
    let tabLatestCollection: String = "LatestCollection"
    let tabAlbum: String = "AlbumCollection"
    
    init(){

    }
    func getTabProduct() -> String {
        return tabProduct
    }
    func getTabCategory() -> String {
        return tabCategory
    }
    func getTabProvince() -> String {
        return tabProvince
    }
    func getTabMyCollection() -> String {
        return tabMyCollection
    }
    func getTabLatestCollection() -> String {
        return tabLatestCollection
    }
    func getTabAlbum() -> String {
        return tabAlbum
    }
    
    func createBodyWithParameters(parameters: NSMutableDictionary?,boundary: String) -> NSData {
        let body = NSMutableData()
        
        if parameters != nil {
            for (key, value) in parameters! {
                
                if(value is String || value is NSString){
                    body.appendString(string: "--\(boundary)\r\n")
                    body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                    body.appendString(string: "\(value)\r\n")
                }
                else if(value is [UIImage]){
                    var i = 0;
                    for image in value as! [UIImage]{
                        let filename = "image\(i).jpg"
                        let data = UIImageJPEGRepresentation(image,1);
                        let mimetype = "image/jpg"
                        
                        body.appendString(string: "--\(boundary)\r\n")
                        body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
                        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
                        body.append(data!)
                        body.appendString(string: "\r\n")
                        i += 1;
                    }
                    
                    
                }
            }
        }
        body.appendString(string: "--\(boundary)--\r\n")
        return body
    }

    
}

extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

final class UserInfo {
    static let user = UserInfo()
    
    var id: String!
    var name : String!
    var email : String!
    var imageUrl : String!
}

