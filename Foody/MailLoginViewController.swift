//
//  MailLoginViewController.swift
//  Foody
//
//  Created by Le NK on 5/25/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class MailLoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var forgetBtn: UIButton!
    
    let userService = UserService()
    var userList  = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "register-bg")!)
        self.loginBtn.layer.borderColor = UIColor.white.cgColor
    }

    
    @IBAction func clickBack(_ sender: UIButton){
        self.dismissOne()
    }
    
    @IBAction func clickSignUp(_ sender: UIButton){
        self.goToStory("Second", "SignUpStory")
    }
    
    @IBAction func clickForgetPass(_ sender: UIButton){
        self.goToStory("Second", "ForgetPassStory")
    }
    
    @IBAction func clickLogin(_sender: UIButton){
        if emailField.text == "" || passwordField.text == "" {
            self.showAlertMessage("Tên đăng nhập và mật khẩu không được để trống")
            return
        }
        userService.fetchUserByEmail(email: self.emailField.text!){ [weak self] (userList, error) in
            if userList.count == 1  && userList[0].password == self?.passwordField.text {
                UserDefaults.standard.setValue(userList[0].password, forKey: "password")
                UserDefaults.standard.setValue(userList[0].email, forKey: "email")
                UserDefaults.standard.setValue(userList[0].name, forKey: "name")
                DispatchQueue.main.async {
                    self?.showSuccessMessage("Đăng nhập thành công")
                }
            }else{
                DispatchQueue.main.async {
                    self?.showAlertMessage("Không đúng thông tin đăng nhập")
                }
            }
        }

    }
    
    

}

