//
//  CategoryListCell.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/25/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class CategoryListCell: UITableViewCell {
    
    @IBOutlet weak var labelCategoryName: UILabel!
    @IBOutlet weak var picturePreview: UIImageView!
    var productCategory: ProductCategory!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(data: ProductCategory){
        labelCategoryName.text = data.name
        picturePreview.loadImage(urlString: data.urlphoto)
    }
}
