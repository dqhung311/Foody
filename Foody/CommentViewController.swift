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
        self.fetchCommentByEmail(getLoginEmail())
        self.reloadtableview()

    }
    
    func reloadtableview(){
        DispatchQueue.main.async {
            self.tableViewComment.reloadData()
        }
    }

    func fetchCommentByEmail(_ email: String){
        commentService.fetchAll(email){ [weak self] (commentList, error) in
            self?.commentList = commentList
            DispatchQueue.main.async {
                self?.tableViewComment.reloadData()
            }
        }
    }
    
    @IBAction func clickBack(_ sender: UIButton){
        self.dismissOne()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if commentList.count == 0{
            showAlertMessage("Bạn chưa có Comment nào cả, vui lòng comment!")        }
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
            let otherHeight = cell.frame.height - cell.commentContent.frame.height
            let content = commentList[indexPath.row].comment
            let paddingOfText : CGFloat = 2
            let heightOfText = heightForView(text: content, font: cell.commentContent.font, width: cell.bounds.width - paddingOfText)
            cellheight = heightOfText + otherHeight
        }
        return cellheight
    }
    
}
