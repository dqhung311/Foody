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
        let storyboard = UIStoryboard(name: "Second", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginStoryBoard")
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func signUpClick(sender: AnyObject) {
        let newuser = Users(self.emailField.text!, passwordField!.text!, displayNameField!.text!)
        
    }
    
    func dissmissall(){
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
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
            self.dissmissall()
        })
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
