//
//  RegisterViewController.swift
//  Foody
//
//  Created by Le NK on 5/25/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var signInPhone: UIButton!
    @IBOutlet weak var signInEmail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "register-bg")!)
        self.signInPhone.layer.borderColor = UIColor.white.cgColor
        self.signInEmail.layer.borderColor = UIColor.white.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func emailLoginClick(_ sender: UIButton){
        self.performSegue(withIdentifier: "MailLoginSegue", sender: sender)
        
    }
    
    @IBAction func signUpClick(_ sender: UIButton){
        self.performSegue(withIdentifier: "ToSignUpSegue", sender: sender)
    }
    
    @IBAction func clickBack(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
}
