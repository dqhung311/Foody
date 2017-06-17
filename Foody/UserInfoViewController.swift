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
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    let user = Users()
    let userService = UserService()
    var userStore = [Users]()
    var avatarSelected = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelWelcomeName.text = self.getLoginName()
        activity.isHidden = true
        avatar.loadImage(urlString: getUserImageUrl(user: nil))
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.white.cgColor
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
        //print(UserInfo().imageUrl)
        
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.clipsToBounds = true
        txtEmail.text = getLoginEmail()
        txtName.text = getLoginName()
        
        
        TopAccountManager.backgroundColor = UIColor(patternImage: UIImage(named: "background-cover")!)
        //btnSaveInfo.layer.cornerRadius = 2
        //btnSaveInfo.layer.masksToBounds = true
        
        
    }

    @IBAction func clickBack(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func gotoSelectionView(_ sender: UIButton){
        self.performSegue(withIdentifier: "SelectionView", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) { //Ham lay screen moi .
        
        if let vc = segue.destination as? SelectionViewController {
            vc.delegate = self
            if (sender as! UIButton?) != nil {
                vc.viewCurrent = Config().getTabAlbum()
                vc.hasMultiple = false
                
            }
        }
    }
    
    @IBAction func saveUserInfo(){
        activity.isHidden = false
        activity.startAnimating()
        
        user.email = txtEmail.text ?? ""
        user.name = txtName.text ?? ""
        user.id = self.getId()
        user.password = txtPassword.text ?? ""
        user.password_confirm = txtConfirmPassword.text ?? ""
   
        userService.updateUser(sender: user,imagesdata: avatarSelected ){ (result) -> Void in
            var title = "Lỗi"
            var dismiss = false
            let arResult = result?.components(separatedBy: "|")
            
            var message = result
            
            if(arResult?[0] == "ok"){
                dismiss = true
                title = "Chúc mừng"
                message = "Đã cập nhật thành công"
                //UserDefaults.standard.setValue(, forKey: "password")
                UserDefaults.standard.setValue(self.user.email, forKey: "email")
                UserDefaults.standard.setValue(self.user.name, forKey: "name")
                UserDefaults.standard.setValue(arResult?[2], forKey: "image_url")
                
            }
            
            DispatchQueue.main.async {
                self.activity.stopAnimating()
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Đóng", style: .default, handler: { action in
                    if(dismiss){
                        if (arResult?[3] == "1")  {  //Logout
                            self.signOut()
                        }else{
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                    
                })
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                self.activity.isHidden = true
            }
            
        }
        
    }

}

extension UserInfoViewController : SelectionDelegate {
    func didSelect(value: Any) {
        
        if let value = value as? UIImage {
            print("a")
            avatarSelected.removeAll()
            avatar.image = value
            avatarSelected.append(value)
        }
        
    }
}
