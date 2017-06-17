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
    
    @IBOutlet weak var btnGoToProduct: UIButton!
    @IBOutlet weak var btnGoToProductArrow: UIButton!
    
    @IBOutlet weak var btnGoToCollection: UIButton!
    @IBOutlet weak var btnGoToCollectionArrow: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        if(checkLogin()){
            NameLabel.text = self.getLoginName()
        }
        avatar.loadImage(urlString: getUserImageUrl(user: nil))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BackBtn.isHidden = true
        NameLabel.isHidden = true
        if self.checkLogin() {
            
            newHeightConstraint.constant = 160
            newTopConstraint.constant = 0
            LoginBtn.isHidden = true
            ContinueBtn.isHidden = true
            UserIcon.isHidden = true
            MenuBar.isHidden = true
            BackBtn.isHidden = false
            NameLabel.isHidden = false
            
            
            avatar = UIImageView(frame: CGRect(x: (self.view.frame.width/2)-35, y: 70, width: 70, height: 70))
            //avatar.backgroundColor = UIColor.red
            avatar.layer.borderWidth = 1
            avatar.layer.borderColor = UIColor.white.cgColor
            avatar.layer.cornerRadius = avatar.frame.height/2
            avatar.clipsToBounds = true
            
            self.view.addSubview(avatar)
            
            TopAccountManager.backgroundColor = UIColor(patternImage: UIImage(named: "background-cover")!)
            TopAccountManager.contentMode = UIViewContentMode.scaleAspectFit
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
            self.goToStory("Second","LoginStoryBoard")
        }else{
            self.goToStory("AcountManager","CommentView")
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let svc = segue.destination as? CollectionManagerViewController {
            
            print("aaa")
            
            if let sender = sender as? UIButton{
            if (sender === btnGoToCollection ||  sender === btnGoToCollectionArrow) {
                svc.viewCurrent = Config().getTabMyCollection()
            }
                if (sender === btnGoToProduct ||  sender === btnGoToProductArrow) {
                    svc.viewCurrent = Config().getTabProduct()
                }
            }
            
        }
    }
    @IBAction func collectionManager(_ sender: UIButton){
        if !self.checkLogin() {
            // chưa login
            self.goToStory("Second","LoginStoryBoard")
        }else{
            /*
            // login rồi
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CollectionStoryBoard")
            if let vc = vc as? CollectionViewController {
                vc.viewCurrent = Config().getTabMyCollection()
                self.present(vc, animated: true, completion: nil)
            }*/
            //self.goToStory("AcountManager", "UserInfoView")
            self.performSegue(withIdentifier: "ManageItems", sender: sender)
            
        }
    }
    
    @IBAction func userInfoManager(_ sender: UIButton){
        if !self.checkLogin() {
            // chưa login
            self.goToStory("Second","LoginStoryBoard")
        }else{
            // login rồi
            self.goToStory("AcountManager", "UserInfoView")
        }
    }
    
    @IBAction func productManager(_ sender: UIButton){
        if !self.checkLogin() {
            // chưa login
            self.goToStory("Second","LoginStoryBoard")
        }else{
            // login rồi
            self.performSegue(withIdentifier: "ManageItems", sender: sender)
        }
    }
    

}
