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
    @IBOutlet weak var labelWelcomeName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var btnSaveInfo: UIButton!

    let userService = UserService()
    var userStore = [Users]()
    
//    var user = Users()
//    let config = Config()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelWelcomeName.text = self.getLoginName()
        /*
        avatar = UIImageView(frame: CGRect(x: (self.view.frame.width/2)-50, y: 70, width: 100, height: 100))
        avatar.backgroundColor = UIColor.red
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.clipsToBounds = true
        avatar.loadImage(urlString: getUserImageUrl(user: nil))
        self.view.addSubview(avatar)
        */
        avatar.loadImage(urlString: getUserImageUrl(user: nil))
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.clipsToBounds = true
        TopAccountManager.backgroundColor = UIColor(patternImage: UIImage(named: "login_bg")!)
        //btnSaveInfo.layer.cornerRadius = 2
        //btnSaveInfo.layer.masksToBounds = true
        
        
    }

    @IBAction func clickBack(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    

}
