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
}
