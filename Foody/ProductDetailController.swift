//
//  ProductDetailControllerViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/26/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class ProductDetailController: UIViewController {
    
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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var productItem  = ProductItem()
    let productService = ProductService()
    
    
        
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
    
    }
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        self.scrollView.contentSize = CGSize(width: view.frame.size.width, height: 800);
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
