//
//  AccountManagerViewController.swift
//  Foody
//
//  Created by Le NK on 6/6/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class AccountManagerViewController: UIViewController {

    @IBOutlet weak var TopAccountManager: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if self.checkLogin() {
//            TopAccountManager.frame.size.height = 200
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkLogin() -> Bool{
        let password: String = UserDefaults.standard.value(forKey: "password") as! String
        let email: String = UserDefaults.standard.value(forKey: "email") as! String
        if password.characters.count > 0 && email.characters.count > 0{
            return true
        }else{
            return false
        }
    }
    
    func goToLogin(){
        let storyboard = UIStoryboard(name: "Second", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginStoryBoard")
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func commentManager(_ sender: UIButton){
        if !self.checkLogin() {
            // chưa login
            self.goToLogin()
        }else{
            // login rồi
        }
    }
    
    @IBAction func collectionManager(_ sender: UIButton){
        if !self.checkLogin() {
            // chưa login
            self.goToLogin()
        }else{
            // login rồi
        }
    }
    
    @IBAction func contactManager(_sender: UIButton){
        if !self.checkLogin() {
            // chưa login
            self.goToLogin()
        }else{
            // login rồi
        }
    }
    
    @IBAction func productManager(_sender: UIButton){
        if !self.checkLogin() {
            // chưa login
            self.goToLogin()
        }else{
            // login rồi
        }
    }
    

}
