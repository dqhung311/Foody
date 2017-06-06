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
        print(self.checkLogin())
//        if self.checkLogin() {
//            print(self.checkLogin())
//            if let password = UserDefaults.standard.value(forKey: "password") as? String,
//                let email = UserDefaults.standard.value(forKey: "email") as? String{
//                print(password)
//                print(email)
//            }
////            TopAccountManager.frame.size.height = 200
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func clickBack(_ sender: UIButton){
        self.dismissAll()
    }
    
    @IBAction func clickSignout(_sender: UIButton){
        self.signOut()
    }
    @IBAction func clickToLogin(_ sender: UIButton){
        self.goToStory("Second","LoginWithEmail")
    }
    
    @IBAction func commentManager(_ sender: UIButton){
        if !self.checkLogin() {
            // chưa login
            self.goToStory("Second","LoginStoryBoard")
        }else{
            // login rồi
        }
    }
    
    @IBAction func collectionManager(_ sender: UIButton){
        if !self.checkLogin() {
            // chưa login
            self.goToStory("Second","LoginStoryBoard")
        }else{
            // login rồi
        }
    }
    
    @IBAction func contactManager(_sender: UIButton){
        if !self.checkLogin() {
            // chưa login
            self.goToStory("Second","LoginStoryBoard")
        }else{
            // login rồi
        }
    }
    
    @IBAction func productManager(_sender: UIButton){
        if !self.checkLogin() {
            // chưa login
            self.goToStory("Second","LoginStoryBoard")
        }else{
            // login rồi
        }
    }
    

}
