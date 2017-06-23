//
//  TableViewCell2.swift
//  Foody
//
//  Created by Dao Quang Hung on 6/22/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class DetailOtherProductCell: UITableViewCell {
    
    @IBOutlet weak var collectionView2: UICollectionView!
    var productItem  = [ProductItem]()
    
    override func awakeFromNib() {
        collectionView2.backgroundColor = UIColor.clear.withAlphaComponent(0)
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
}
extension DetailOtherProductCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return productItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionOtherProductImage", for: indexPath)
        print("fdfdsfsdf")
        
        if let cell = cell as? CollectionOtherProductImage {
           cell.imageProduct.loadImage(urlString: productItem[indexPath.row].urlphoto)
        }
        return cell
    }
    
}
