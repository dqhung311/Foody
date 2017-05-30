//
//  FoodyAPI.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/30/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class FoodyAPI{
    private let session : URLSession!
    init() {
        session = URLSession(configuration: .default)
    }
    
    func connectAPI(urlJson: String, object: AnyObject, completion:  @escaping ([AnyObject], NSError?) -> Void){
        guard let url = URL(string: urlJson) else {
            let error = NSError(domain: "ProductService", code: 404, userInfo: [NSLocalizedDescriptionKey: "URL is invalid!"])
            completion([], error)
            return
        }
        
        let task = session.dataTask(with: url, completionHandler: {[weak self] (data, res, err) in
            guard let jsonData = data, let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {
                let error = NSError(domain: "ProductService", code: 501, userInfo: [NSLocalizedDescriptionKey: "Response is invalid!"])
                completion([], error)
                //closure completion duoc goi tu ham callback cua dataTask, nen phai them thuoc tinh @escaping
                return
            }
            
            //object.parseJson(json: jsonObject as? [String: Any], completion: completion)
        })
        
        task.resume()
    }

}
