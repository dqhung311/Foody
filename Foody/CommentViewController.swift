//
//  CommentViewController.swift
//  Foody
//
//  Created by Le NK on 6/6/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var TopAccountManager: UIView!
    
    @IBOutlet weak var tableViewComment: UITableView!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    var avatar: UIImageView = UIImageView()
    
    let commentService = CommentService()
    var commentList = [Comments]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatar = UIImageView(frame: CGRect(x: (self.view.frame.width/2)-35, y: 70, width: 70, height: 70))
        //avatar.backgroundColor = UIColor.red
        
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.clipsToBounds = true
        avatar.loadImage(urlString: getUserImageUrl(user: nil))
        self.view.addSubview(avatar)
        
        TopAccountManager.backgroundColor = UIColor(patternImage: UIImage(named: "background-cover")!)
        TopAccountManager.contentMode = UIViewContentMode.scaleAspectFit
        
        NameLabel.text = self.getLoginName()
        self.fetchCommentUser("userID=" + self.getId())

    }
    
    func reloadtableview(){
        DispatchQueue.main.async {
            self.tableViewComment.reloadData()
        }
    }

    func fetchCommentUser(_ email: String){
        commentService.fetchAll(email){ [weak self] (commentList, error) in
            self?.commentList = commentList
            DispatchQueue.main.async {
                self?.tableViewComment.reloadData()
            }
        }
    }
    @IBAction func toogleEditingMode(_ sender: UIButton){
        if(tableViewComment.isEditing){
            sender.setTitle("Edit", for: .normal)
            tableViewComment.setEditing(false, animated:true)
        }else{
            sender.setTitle("Done", for: .normal)
            tableViewComment.setEditing(true, animated:true)
        }
        
    }
    
    @IBAction func clickBack(_ sender: UIButton){
        self.dismissOne()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell")
        if let cell = cell as? CommentCell {
            cell.loadCell(data: commentList[indexPath.row])
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellheight: CGFloat = CGFloat(0)
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell")
        if let cell = cell as? CommentCell {
            let otherHeight = cell.thumbnail.frame.height + 10 + 10
            let content = commentList[indexPath.row].comment
            let paddingOfText : CGFloat = 2
            let heightOfText = heightForView(text: content, font: cell.commentContent.font, width: cell.bounds.width - paddingOfText)
            cellheight = heightOfText + otherHeight + 10
        }
        return cellheight
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            let title = "Delete"
            let mesage = "Are you sure want to delete this item?"
            let ac = UIAlertController(title: title, message: mesage, preferredStyle: .actionSheet)
            let cancelaction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelaction)
            let deleteaction = UIAlertAction(title: "Delete", style: .destructive, handler: {(action) -> Void in
                self.btnEdit.setTitle("Edit", for: .normal)
                self.tableViewComment.setEditing(false, animated:true)
                let item = self.commentList[indexPath.row]
                self.commentService.deleteById(item.id)
                DispatchQueue.main.async {
                    self.fetchCommentUser("userID=" + self.getId())
                }
                
            })
            ac.addAction(deleteaction)
            
            present(ac, animated: true, completion: nil)
            
        }
    }
    
}
