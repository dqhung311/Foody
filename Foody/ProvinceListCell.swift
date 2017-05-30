//
//  PlaceListCell.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/25/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class ProvinceListCell: UITableViewCell {
    @IBOutlet weak var labelProvinceName: UILabel!
    var productProvince: ProductProvince!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func loadCell(data: ProductProvince){
        labelProvinceName.text = data.name
    }
    

}
