//
//  AddCommentViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 6/14/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class AddCommentViewController: UIViewController {
    
    @IBOutlet weak var btnLabel: UIButton!
    @IBOutlet weak var viewAddComment: UIView!
    
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductAddress: UILabel!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtComment: UITextField!
    
    var productItem  = ProductItem()
    let commentService = CommentService()
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLabel.layer.cornerRadius = 5
        btnLabel.layer.masksToBounds = true
        labelProductName.text = productItem.name
        labelProductAddress.text = productItem.address
        activity.isHidden = true
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveComment(){
        activity.isHidden = false
        activity.startAnimating()
        let newComment = Comments()
        newComment.name = (txtTitle?.text)!
        newComment.comment = (txtComment?.text)!
        newComment.product_id = productItem.id
        newComment.user_id = self.getId()
        
        commentService.addNewComment(sender: newComment){ (result) -> Void in
            var title = "Lỗi"
            var dismiss = false
            var message = result
            if(result == "ok"){
                dismiss = true
                title = "Chúc mừng"
                message = "Đăng bình luận thành công"
            }
            
            DispatchQueue.main.async {
                self.activity.stopAnimating()
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Đóng", style: .default, handler: { action in
                    if(dismiss){
                        self.dismiss(animated: true, completion: nil)
                    }
                })
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                self.activity.isHidden = true
            }
            
        }
    }
    
    @IBAction func disMist(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    

}
