//
//  UserInfoViewController.swift
//  Foody
//
//  Created by Le NK on 6/7/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    @IBOutlet weak var TopAccountManager: UIView!

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var displayName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    var avatar: UIImageView = UIImageView()
    
    let userService = UserService()
    var userStore = [Users]()
    
//    var user = Users()
    let config = Config()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        userService.fetchUserByEmail(email: self.getLoginEmail()){ [weak self] (userList, error) in
//            if userList.count == 1{
//                self?.user = userList[0]
//            }
//            
//        }
        
        self.displayName.text = self.config.currentUserInfo?.name
        avatar = UIImageView(frame: CGRect(x: (self.view.frame.width/2)-50, y: 70, width: 100, height: 100))
        avatar.backgroundColor = UIColor.red
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.clipsToBounds = true
        avatar.loadImage(urlString: getUserImageUrl(user: nil))
        self.view.addSubview(avatar)
        
        TopAccountManager.backgroundColor = UIColor(patternImage: UIImage(named: "login_bg")!)
        
        NameLabel.text = self.getLoginName()
        
    }

    @IBAction func clickBack(_ sender: UIButton){
        self.dismissOne()
    }
    

}
