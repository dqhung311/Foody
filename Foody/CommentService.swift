//
//  CommentService.swift
//  Foody
//
//  Created by Le NK on 6/6/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit
import Alamofire

protocol ProtocolCommentService {
    
    func fetchAll(_ query: String, completion: @escaping ([Comments], NSError?) -> Void)
    
    func addNewComment(sender: AnyObject, handler:@escaping (_ result:String?)-> Void)
    
}
class CommentService: ProtocolCommentService{
    
    let strUrl = "http://anphatkhanh.vn/foody/comment/?"
    let strUrlEdit = "http://anphatkhanh.vn/foody/comment/edit.php"
    let strUrlDelete = "http://anphatkhanh.vn/foody/comment/delete.php"
    
    
    
    private let session : URLSession!
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func parseJson(json: [String: Any]?, completion: ([Comments], NSError?) -> Void){
        var commentStore = [Comments]()
        if let comments = json?["comments"] as? [[String:Any]] {
            for p in comments{
                let comment = Comments()
                if let id = p["id"] as? String {
                    comment.id = id
                }
                if let name = p["name"] as? String {
                    comment.name = name
                }
                if let comments = p["comments"] as? String {
                    comment.comment = comments
                }
                if let product_id = p["product_id"] as? String {
                    comment.product_id = product_id
                }
                if let product_address = p["product_address"] as? String {
                    comment.product_address = product_address
                }
                if let product_name = p["product_name"] as? String {
                    comment.product_name = product_name
                }
                if let product_image = p["product_image"] as? String {
                    comment.product_image = product_image
                }
                if let product_score = p["product_score"] as? String {
                    comment.product_score = product_score
                }
                if let product_province_name = p["product_province_name"] as? String {
                    comment.product_province_name = product_province_name
                }
                if let product_category_name = p["product_category_name"] as? String {
                    comment.product_category_name = product_category_name
                }
                if let product_price = p["product_price"] as? String {
                    comment.product_price = product_price
                }
                if let total_like = p["total_like"] as? String {
                    comment.total_like = total_like
                }
                
                commentStore.append(comment)
            }
        }
        completion(commentStore, nil)
    }
    
    
    
    func fetchAll(_ query: String, completion: @escaping ([Comments], NSError?) -> Void){
        Alamofire.request(strUrl+query).responseJSON { response in
            if let JSON = response.result.value {
                self.parseJson(json: JSON as? [String : Any], completion: completion)
            }
        }
    }
    
    func deleteById(_ commentID: String){
        let parameters: Parameters = [
            "id": commentID
        ]
        Alamofire.request(strUrlDelete, method: .post, parameters: parameters).responseJSON
    }
    
    func addNewComment(sender: AnyObject, handler: @escaping (String?) -> Void) {
        if let comment = sender as? Comments{
            
            let param = [
                "name" : comment.name,
                "content": comment.comment,
                "user_id": comment.user_id,
                "product_id": comment.product_id
            ] as NSMutableDictionary
            
            
            let boundary = "Boundary-\(NSUUID().uuidString)"
            let url = NSURL(string: strUrlEdit)
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

    
}
