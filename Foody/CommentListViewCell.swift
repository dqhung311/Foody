//
//  CommentListViewCell.swift
//  Foody
//
//  Created by Dao Quang Hung on 6/21/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class CommentListViewCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var commentTitle: UILabel!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var commentDate: UILabel!
    @IBOutlet weak var viewTopComment: UIView!
    @IBOutlet weak var viewContentComment: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell( data: Comments){
        commentTitle.text = data.name
        userName.text = data.user_name
        commentText.text = data.comment
        commentDate.text = data.date_create
        avatarImage.loadImage(urlString: data.user_avatar)
        avatarImage.layer.cornerRadius = avatarImage.frame.width/2.0
        avatarImage.clipsToBounds = true
    }

}
