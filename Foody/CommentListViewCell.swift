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
    @IBOutlet weak var commentTitle: UILabel!
    @IBOutlet weak var commentText: UILabel!

    
    
    
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
        commentText.text = data.comment
        
    }

}
