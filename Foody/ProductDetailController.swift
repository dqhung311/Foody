//
//  ProductDetailControllerViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/26/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class ProductDetailController: UIViewController{
    
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
    @IBOutlet weak var viewOtherImage: UIView!
    @IBOutlet weak var viewCommentList: UIView!
    
    
    
    
    var heightOtherImageView: CGFloat = 0
    var heightCommentView: CGFloat = 0
    
    var productItem  = ProductItem()
    let productService = ProductService()
    
    func listViewCommentUIView(){
        
       
       
    }
    
    func listOtherImageUIView(){
        let screenSize: CGRect = UIScreen.main.bounds
        let paddingBetweenImage = Int(screenSize.width * 0.5 + 5)
        let widthImage = Int(screenSize.width * 0.5), heightImage = Int(screenSize.width * 0.35)
        var row = 1
        var indexrowBreak = 0
        let maxChOn1Row = 2
       
        for i in 0..<productItem.otherimage.count{
            
            var x_button = i * paddingBetweenImage
            var y_button = 0
            if(i != 0 && i == maxChOn1Row * row){
                indexrowBreak = 0
                row += 1
            }
            if(i >= maxChOn1Row && i <= maxChOn1Row * row) {
                x_button = indexrowBreak * paddingBetweenImage
                y_button = ((heightImage + 5) * row) - (heightImage + 5)
                indexrowBreak += 1
            }
            let imageView = UIImageView()
            imageView.loadImage(urlString: productItem.otherimage[i])
            imageView.frame = CGRect(x: x_button, y: y_button, width: widthImage, height: heightImage)
            viewOtherImage.addSubview(imageView)
        }
        self.viewOtherImage.frame.size.height = CGFloat(row * heightImage) + 5
        heightOtherImageView = self.viewOtherImage.frame.size.height
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelScore.layer.cornerRadius = labelScore.frame.width/2.0
        labelScore.clipsToBounds = true
        
        
        labelProductName.text = productItem.name
        labelProductNameDetail.text = productItem.name
        pictureImage.loadImage(urlString: productItem.urlphoto)
        labelTotalComment.text = String(productItem.total_comment)
        labelTotalPicture.text = String(productItem.otherimage.count)
        labelTotalCollection.text = String(productItem.total_like)
        labelScore.text = productItem.score
        labelPrice.text = productItem.price
        labelAddress.text = productItem.address + " " + productItem.province_name
        labelCategory.text = productItem.category_name
        
        self.listOtherImageUIView()
        self.listViewCommentUIView()
        self.view.addSubview(self.scrollView)
        
    }
    
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.scrollView.frame.height + self.heightOtherImageView)
            
            print(self.heightOtherImageView)
            
            self.viewCommentList.translatesAutoresizingMaskIntoConstraints = false
            let cn5 = NSLayoutConstraint(item: self.viewCommentList, attribute: .top, relatedBy: .equal, toItem: self.viewOtherImage, attribute: .bottom, multiplier: 1.0, constant: self.heightOtherImageView - 20)
            
            self.view.addConstraint(cn5)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func disMist(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
