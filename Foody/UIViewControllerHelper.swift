//
//  UIViewControllerHelper.swift
//  Foody
//
//  Created by Le NK on 6/6/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

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
        let alertController = UIAlertController(title: "Lỗi", message: "\(message)", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Đóng", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showSuccessMessage(_ message: String){
        let alertController = UIAlertController(title: "Thành công", message: "\(message)", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Đóng", style: .default, handler: { action in
            self.dismissAll()
        })
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
