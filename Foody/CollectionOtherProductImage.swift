//
//  CollectionImageViewCell.swift
//  Foody
//
//  Created by Dao Quang Hung on 6/22/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class CollectionOtherProductImage: UICollectionViewCell {
    
    @IBOutlet weak var imageProduct: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //update(with: nil)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        //update(with: nil)
    }
    
    func loadCell(data: String){
        imageProduct.loadImage(urlString: data)
    }
}
