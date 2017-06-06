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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clickBack(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickSignUp(_ sender: UIButton){
        self.performSegue(withIdentifier: "ToRegisterSegue", sender: sender)
        UserDefaults.standard.setValue("ok", forKey: "password")
    }
    
    @IBAction func clickForgetPass(_ sender: UIButton){
        self.performSegue(withIdentifier: "ToForgetSegue", sender: sender)
        UserDefaults.standard.setValue("no", forKey: "password")
    }
    
    @IBAction func clickLogin(_sender: UIButton){
        if emailField.text == "" || passwordField.text == "" {
            self.showAlertMessage("Tên đăng nhập và mật khẩu không được để trống")
            return
        }
        userService.fetchUserByEmail(email: "123@123.com"){ [weak self] (userList, error) in
            print(userList.count)
            if userList.count == 1 {
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
    func showAlertMessage(_ message: String){
        let alertController = UIAlertController(title: "Warning", message: "\(message)", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    func showSuccessMessage(_ message: String){
        let alertController = UIAlertController(title: "Success", message: "\(message)", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close", style: .default, handler: { action in
            self.goToHome()
        })
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func goToHome(){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeStoryboard")
        self.present(vc, animated: true, completion: nil)
    }


}

