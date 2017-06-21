//
//  CommentCell.swift
//  Foody
//
//  Created by Le NK on 6/7/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var commentName: UILabel!
    @IBOutlet weak var commentContent: UILabel!
    @IBOutlet weak var score: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(data: Comments){
            productName.text = data.product_name
            commentName.text = data.name 
            commentContent.text = data.comment
            score.text = data.product_score
            thumbnail.loadImage(urlString: data.product_image)
    }

}
