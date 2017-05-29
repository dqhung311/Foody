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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
