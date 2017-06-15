//
//  AlbumListCell.swift
//  Foody
//
//  Created by Dao Quang Hung on 6/13/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class AlbumListCell: UITableViewCell {
    
    @IBOutlet weak var albumImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //update(with: nil)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        //update(with: nil)
    }
    
    func loadCell(image: UIImage){
        albumImage.image = image
    }
}
