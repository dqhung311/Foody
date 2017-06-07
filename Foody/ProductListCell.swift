//
//  ProductListCell.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/25/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class ProductListCell: UITableViewCell {
    
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductAddress: UILabel!
    @IBOutlet weak var picturePreview: UIImageView!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelTotalComment: UILabel!
    @IBOutlet weak var labelTotalImage: UILabel!
    
    var productItem: ProductItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func loadCell(data: ProductItem){
        labelProductName.text = data.name
        labelProductAddress.text = data.address
        labelScore.text = data.score
        labelTotalImage.text = String(data.otherimage.count)
        labelTotalComment.text = String(data.total_comment)
        labelScore.layer.cornerRadius = labelScore.frame.width/2.0
        labelScore.clipsToBounds = true
        picturePreview.loadImage(urlString: data.urlphoto)
    }
    
    

}
