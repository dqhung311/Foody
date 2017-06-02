//
//  SearchCell.swift
//  Foody
//
//  Created by Le NK on 5/31/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductAddress: UILabel!
    @IBOutlet weak var picturePreview: UIImageView!
    
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
        picturePreview.loadImage(urlString: data.urlphoto)
    }
}
