//
//  UIViewControllerHelper.swift
//  Foody
//
//  Created by Le NK on 6/6/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit
import Alamofire

extension UIViewController {
    
    func dismissOne(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func dismissAll(){
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func goToStory(_ name: String,_ story: String){
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: story)
        self.present(vc, animated: true, completion: nil)
    }
    
    func checkLogin() -> Bool{
        if let password = UserDefaults.standard.value(forKey: "password") as? String{
            if let email = UserDefaults.standard.value(forKey: "email") as? String{
                if password.characters.count > 0 && email.characters.count > 0{
                    return true
                }else{
                    return false
                }
            }
        }
        return false
    }
    
    func signOut(){
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "name")
        self.dismissAll()
    }
    
    func showAlertMessage(_ message: String){
        let alertController = UIAlertController(title: "Warning", message: "\(message)", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showSuccessMessage(_ message: String){
        let alertController = UIAlertController(title: "Success", message: "\(message)", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close", style: .default, handler: { action in
            self.dismissAll()
        })
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    /*
    func uploadImagesAndData(params:[String : AnyObject]?,image1: UIImage,image2: UIImage,image3: UIImage,image4: UIImage,headers : [String : String]?, completionHandler: @escaping CompletionHandler) -> Void {
        
        let imageData1 = UIImageJPEGRepresentation(image1, 0.5)!
        let imageData2 = UIImageJPEGRepresentation(image2, 0.5)!
        
        let imageData3 = UIImageJPEGRepresentation(image3, 0.5)!
        
        let imageData4 = UIImageJPEGRepresentation(image4, 0.5)!
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in params! {
                if let data = value.data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }
            
            multipartFormData.append(imageData1, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            multipartFormData.append(imageData2, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            multipartFormData.append(imageData3, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            multipartFormData.append(imageData4, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            
        },
                         to: "", encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload
                                    .validate()
                                    .responseJSON { response in
                                        switch response.result {
                                        case .success(let value):
                                            print("responseObject: \(value)")
                                        case .failure(let responseError):
                                            print("responseError: \(responseError)")
                                        }
                                }
                            case .failure(let encodingError):
                                print("encodingError: \(encodingError)")
                            }
        })
    }
    */
    
}


