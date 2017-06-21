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
    
    func setHeightCell(){
        let screenSize = UIScreen.main.bounds
        let separatorHeight = CGFloat(3.0)
        let additionalSeparator = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height - separatorHeight, width: screenSize.width, height: separatorHeight))
        additionalSeparator.backgroundColor = UIColor.gray
        contentView.addSubview(additionalSeparator)
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
