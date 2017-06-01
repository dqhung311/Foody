//
//  CollectionListCell.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/29/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class CollectionListCell: UICollectionViewCell {
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelTotalLike: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        //update(with: nil)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        //update(with: nil)
    }
    
    func loadCell(data: CollectionItem){
        labelProductName.text = data.product_name
        imageView.loadImage(urlString: data.product_image)
        labelTotalLike.text = (data.total_like) + " lưu"
    }
}
