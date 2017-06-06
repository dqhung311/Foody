//
//  SignUpViewController.swift
//  Foody
//
//  Created by Le NK on 5/27/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import AFNetworking
import UIKit


class SignUpViewController: UIViewController {

    @IBOutlet weak var emailField:UITextField!
    @IBOutlet weak var passwordField:UITextField!
    @IBOutlet weak var confirmPasswordField:UITextField!
    @IBOutlet weak var displayNameField:UITextField!
    
    @IBOutlet weak var BackBtn:UIButton!
    @IBOutlet weak var SignInBtn:UIButton!
    @IBOutlet weak var SignUpBtn:UIButton!

    let userService = UserService()
    var userList  = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "register-bg")!)
        self.SignInBtn.layer.borderColor = UIColor.white.cgColor
        self.SignUpBtn.layer.borderColor = UIColor.white.cgColor
        if self.checkLogin(){
            perform(#selector(dismissAll), with: nil, afterDelay: 0)
        }
    }
    
    @IBAction func clickBack(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickSignIn(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "Second", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginStoryBoard")
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func signUpClick(sender: AnyObject) {
        let newuser = Users(self.emailField.text!, passwordField!.text!, displayNameField!.text!)
        userService.registerUser(sender: newuser)
    }
    
}
