//
//  TableViewCell.swift
//  Foody
//
//  Created by Dao Quang Hung on 6/21/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class DetailOtherImageCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var productItem  = ProductItem()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}
extension DetailOtherImageCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return productItem.otherimage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionOtherImage",for: indexPath as IndexPath)
            if let cell = cell as? CollectionOtherImage {
                let dataImage = productItem.otherimage[indexPath.row]
                cell.loadCell(data: dataImage)
            }
            return cell
    }
    
}
