//
//  ProductDetailControllerViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/26/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class ProductDetailController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var labelProductNameDetail: UILabel!
    
    @IBOutlet weak var labelTotalComment: UILabel!
    @IBOutlet weak var labelTotalPicture: UILabel!
    @IBOutlet weak var labelTotalCollection: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var labelProvince: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var productItem  = ProductItem()
    let productService = ProductService()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionOtherImageCell", for: indexPath) as! CollectionOtherImageCell
        
        
        return cell
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        labelScore.layer.cornerRadius = labelScore.frame.width/2.0
        labelScore.clipsToBounds = true
        
        
        view.addSubview(scrollView)
        
        labelProductName.text = productItem.name
        labelProductNameDetail.text = productItem.name
        pictureImage.loadImage(urlString: productItem.urlphoto)
        labelTotalComment.text = "235"
        labelScore.text = productItem.score
        labelPrice.text = productItem.price
        labelAddress.text = productItem.address + " " + productItem.province_name
        labelCategory.text = productItem.category_name
        
    
    }
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        self.scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height);
    }
    func setUIView(data: ProductItem){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func disMist(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    

}


