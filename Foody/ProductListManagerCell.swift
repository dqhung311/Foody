//
//  ProductListManagerCell.swift
//  Foody
//
//  Created by Dao Quang Hung on 6/17/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class ProductListMangerCell: UITableViewCell {
    
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductAddress: UILabel!
    @IBOutlet weak var picturePreview: UIImageView!
    @IBOutlet weak var labelProductScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func loadCell( data: Any){
        labelProductScore.layer.cornerRadius = labelProductScore.frame.width/2.0
        labelProductScore.clipsToBounds = true
        
        if let data = data as? CollectionItem{
        labelProductName.text = data.product_name
        labelProductAddress.text = data.product_address
        picturePreview.loadImage(urlString: data.product_image)
        labelProductScore.text = data.product_score
            
        }
        if let data = data as? ProductItem{
            labelProductName.text = data.name
            labelProductAddress.text = data.address
            picturePreview.loadImage(urlString: data.urlphoto)
            labelProductScore.text = data.score
            
        }
    }
    
    
    
}
