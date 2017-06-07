//
//  UIViewControllerHelper.swift
//  Foody
//
//  Created by Le NK on 6/6/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
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
    
    func heightForView(text:String, font: UIFont, width: CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.bounds.height
    }
    
    func getLoginEmail() -> String{
        if let mail = UserDefaults.standard.value(forKey: "email") as? String{
            return mail
        }else{
            return ""
        }
    }
    
    func getLoginName() -> String{
        if let name = UserDefaults.standard.value(forKey: "name") as? String{
            return name
        }else{
            return ""
        }
    }
    func getUserImageUrl(user: Users?) -> String{
        if let user = user{
            return (user.image_url)
        }else{
            return "http://www.iconsfind.com/wp-content/uploads/2015/08/20150831_55e46ad551392.png"
        }
    }
}
