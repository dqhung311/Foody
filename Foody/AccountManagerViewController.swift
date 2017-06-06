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
    @IBOutlet weak var MenuBar: UIView!
    
    @IBOutlet weak var newHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var newTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var ContinueBtn: UIButton!
    @IBOutlet weak var UserIcon: UIImageView!
    
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var NameLabel: UILabel!
    var avatar: UIImageView = UIImageView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        BackBtn.isHidden = true
        NameLabel.isHidden = true
        if self.checkLogin() {
            newHeightConstraint.constant = 200
            newTopConstraint.constant = 0
            LoginBtn.isHidden = true
            ContinueBtn.isHidden = true
            UserIcon.isHidden = true
            MenuBar.isHidden = true
            BackBtn.isHidden = false
            NameLabel.isHidden = false
            NameLabel.text = self.getLoginName()
            
            avatar = UIImageView(frame: CGRect(x: (self.view.frame.width/2)-50, y: 70, width: 100, height: 100))
            avatar.backgroundColor = UIColor.red
            avatar.layer.borderWidth = 1
            avatar.layer.borderColor = UIColor.white.cgColor
            avatar.layer.cornerRadius = avatar.frame.height/2
            avatar.clipsToBounds = true
            avatar.loadImage(urlString: "http://www.iconsfind.com/wp-content/uploads/2015/08/20150831_55e46ad551392.png")
            self.view.addSubview(avatar)
            
            TopAccountManager.backgroundColor = UIColor(patternImage: UIImage(named: "login_bg")!)
        }
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
