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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.setValue("12345", forKey: "password")
        
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
    }
    
    @IBAction func clickForgetPass(_ sender: UIButton){
        self.performSegue(withIdentifier: "ToForgetSegue", sender: sender)
    }
    
}

