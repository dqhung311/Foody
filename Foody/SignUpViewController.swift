//
//  SignUpViewController.swift
//  Foody
//
//  Created by Le NK on 5/27/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailField:UITextField!
    @IBOutlet weak var passwordField:UITextField!
    @IBOutlet weak var confirmPasswordField:UITextField!
    @IBOutlet weak var displayNameField:UITextField!
    
    @IBOutlet weak var BackBtn:UIButton!
    @IBOutlet weak var SignInBtn:UIButton!
    @IBOutlet weak var SignUpBtn:UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "register-bg")!)
        self.SignInBtn.layer.borderColor = UIColor.white.cgColor
        self.SignUpBtn.layer.borderColor = UIColor.white.cgColor
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func clickBack(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickSignIn(_ sender: UIButton){
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
//        let nn = CoreDataStore.shared.getContext()
    }
    
    @IBAction func signUpClick(sender: AnyObject) {
        let newuser = Users(self.emailField.text!, passwordField!.text!, displayNameField!.text!)
        var request = URLRequest(url: URL(string: "http://anphatkhanh.vn/foody/edit.php")!)
        request.httpMethod = "POST"
        let postString = "email=\(newuser.getEmail())&password=\(newuser.getPassword())&name=\(newuser.getName())"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                DispatchQueue.main.async {
                    self.showAlertMessage("statusCode should be 200, but is \(httpStatus.statusCode)")
                }
            }
            
            let responseString = String(data: data, encoding: .utf8)
            let messageshow = responseString ?? ""
            if messageshow != "OK" {
                DispatchQueue.main.async {
                    self.showAlertMessage(messageshow)
                }
            } else {
                self.showAlertMessage("Đăng ký thành công")
            }
            
        }
        task.resume()
    }
    
    
    func showAlertMessage(_ message: String){
        let alertController = UIAlertController(title: "Warning", message: "\(message)", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
